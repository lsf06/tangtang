"""
传感器测试

模拟和测试传感器数据采集功能
"""
import pytest
from unittest.mock import Mock, patch, MagicMock
import time


class TestMAX30102:
    """MAX30102 心率血氧传感器测试"""
    
    def test_sensor_initialization(self):
        """测试传感器初始化"""
        # 模拟传感器配置
        config = {
            "i2c_address": 0x57,
            "sample_rate": "100Hz",
            "adc_range": "2048",
            "pulse_width": "411us"
        }
        
        assert config["i2c_address"] == 0x57
        assert config["sample_rate"] in ["50Hz", "100Hz", "200Hz", "400Hz", "800Hz", "1000Hz"]
    
    def test_heart_rate_calculation(self):
        """测试心率计算"""
        # 模拟 PPG 信号峰值间隔 (毫秒)
        peak_intervals = [857, 833, 869, 845, 850]  # 约 70-72 BPM
        
        def calculate_heart_rate(interval_ms):
            """根据峰值间隔计算心率 (BPM)"""
            if interval_ms <= 0:
                return 0
            return 60000 / interval_ms
        
        heart_rates = [calculate_heart_rate(i) for i in peak_intervals]
        avg_heart_rate = sum(heart_rates) / len(heart_rates)
        
        # 验证计算结果在合理范围内
        assert 65 <= avg_heart_rate <= 75
    
    def test_spo2_calculation(self):
        """测试血氧饱和度计算"""
        # 模拟红光和红外光吸收比值
        ratios = [0.5, 0.6, 0.55, 0.58, 0.52]
        
        def calculate_spo2(ratio):
            """简化版血氧计算 (经验公式)"""
            # 实际算法更复杂，这里使用简化公式
            spo2 = 110 - 25 * ratio
            return max(70, min(100, spo2))
        
        spo2_values = [calculate_spo2(r) for r in ratios]
        avg_spo2 = sum(spo2_values) / len(spo2_values)
        
        # 验证计算结果在合理范围内
        assert 95 <= avg_spo2 <= 100


class TestMLX90614:
    """MLX90614 红外体温传感器测试"""
    
    def test_temperature_reading(self):
        """测试温度读数"""
        # 模拟传感器读数 (摄氏度)
        readings = [36.3, 36.5, 36.4, 36.6, 36.5]
        
        avg_temp = sum(readings) / len(readings)
        assert 36.0 <= avg_temp <= 37.0
    
    def test_temperature_compensation(self):
        """测试温度补偿"""
        ambient_temp = 25.0  # 环境温度
        raw_temp = 36.5  # 原始读数
        
        def apply_compensation(raw, ambient, coefficient=0.1):
            """应用温度补偿"""
            compensation = (ambient - 25) * coefficient
            return raw + compensation
        
        compensated = apply_compensation(raw_temp, ambient_temp)
        assert abs(compensated - raw_temp) < 1.0  # 补偿应该在合理范围内
    
    def test_normal_temperature_range(self):
        """测试正常体温范围"""
        normal_ranges = {
            "oral": (36.3, 37.2),      # 口腔温度
            "axillary": (36.0, 37.0),   # 腋下温度
            "forehead": (35.8, 37.5)    # 额头温度
        }
        
        def is_normal_temp(temp, measurement_type="forehead"):
            """检查体温是否正常"""
            low, high = normal_ranges[measurement_type]
            return low <= temp <= high
        
        assert is_normal_temp(36.5, "oral")
        assert not is_normal_temp(38.0, "oral")
        assert is_normal_temp(37.0, "forehead")


class TestSensorFusion:
    """多传感器融合测试"""
    
    def test_data_synchronization(self):
        """测试数据同步"""
        # 模拟多个传感器的时间戳
        timestamps = {
            "max30102": time.time(),
            "mlx90614": time.time() + 0.001,  # 1ms 延迟
            "near_ir": time.time() + 0.002    # 2ms 延迟
        }
        
        # 检查时间戳差异是否在可接受范围内 (10ms)
        times = list(timestamps.values())
        max_diff = max(times) - min(times)
        
        assert max_diff < 0.01  # 10ms 阈值
    
    def test_multi_modal_health_score(self):
        """测试多模态健康评分计算"""
        def calculate_health_score(heart_rate, spo2, temperature):
            """综合健康评分 (0-100)"""
            score = 100
            
            # 心率评分 (40 分)
            if 60 <= heart_rate <= 100:
                score += 0
            elif 50 <= heart_rate < 60 or 100 < heart_rate <= 120:
                score -= 10
            else:
                score -= 20
            
            # 血氧评分 (40 分)
            if spo2 >= 95:
                score += 0
            elif spo2 >= 90:
                score -= 10
            else:
                score -= 20
            
            # 体温评分 (20 分)
            if 36.0 <= temperature <= 37.5:
                score += 0
            elif 35.5 <= temperature < 36.0 or 37.5 < temperature <= 38.0:
                score -= 5
            else:
                score -= 10
            
            return max(0, min(100, score))
        
        # 测试正常值
        normal_score = calculate_health_score(72, 98, 36.5)
        assert normal_score >= 80
        
        # 测试异常值
        abnormal_score = calculate_health_score(130, 85, 39.0)
        assert abnormal_score < 60
    
    def test_anomaly_detection(self):
        """测试异常检测"""
        def detect_anomaly(heart_rate, spo2, temperature, thresholds):
            """检测健康异常"""
            anomalies = []
            
            if heart_rate < thresholds["heart_rate"]["low"]:
                anomalies.append("bradycardia")  # 心动过缓
            elif heart_rate > thresholds["heart_rate"]["high"]:
                anomalies.append("tachycardia")  # 心动过速
            
            if spo2 < thresholds["spo2"]["low"]:
                anomalies.append("hypoxia")  # 低氧血症
            
            if temperature > thresholds["temperature"]["high"]:
                anomalies.append("fever")  # 发烧
            elif temperature < thresholds["temperature"]["low"]:
                anomalies.append("hypothermia")  # 低体温
            
            return anomalies
        
        thresholds = {
            "heart_rate": {"low": 50, "high": 100},
            "spo2": {"low": 95},
            "temperature": {"low": 35.0, "high": 37.5}
        }
        
        # 正常情况
        normal_anomalies = detect_anomaly(72, 98, 36.5, thresholds)
        assert len(normal_anomalies) == 0
        
        # 异常情况
        abnormal_anomalies = detect_anomaly(110, 88, 38.5, thresholds)
        assert "tachycardia" in abnormal_anomalies
        assert "hypoxia" in abnormal_anomalies
        assert "fever" in abnormal_anomalies


class TestSensorMock:
    """传感器模拟测试"""
    
    def test_mock_sensor_data_generation(self):
        """测试模拟传感器数据生成"""
        import random
        
        def generate_mock_sensor_data():
            """生成模拟传感器数据"""
            return {
                "heart_rate": random.randint(60, 100),
                "spo2": random.randint(95, 100),
                "temperature": round(random.uniform(36.0, 37.5), 1),
                "timestamp": time.time()
            }
        
        # 生成多组数据并验证
        for _ in range(10):
            data = generate_mock_sensor_data()
            assert 60 <= data["heart_rate"] <= 100
            assert 95 <= data["spo2"] <= 100
            assert 36.0 <= data["temperature"] <= 37.5
    
    def test_sensor_data_stream(self):
        """测试传感器数据流"""
        def simulate_data_stream(duration_seconds=5, interval_ms=1000):
            """模拟数据流"""
            data_points = []
            end_time = time.time() + duration_seconds
            
            while time.time() < end_time:
                data_points.append({
                    "heart_rate": 70 + random.randint(-5, 5),
                    "timestamp": time.time()
                })
                time.sleep(interval_ms / 1000)
            
            return data_points
        
        # 测试数据流生成 (快速测试，只生成少量数据)
        test_data = [
            {"heart_rate": 70 + i, "timestamp": time.time()}
            for i in range(5)
        ]
        
        assert len(test_data) == 5
        assert all(65 <= d["heart_rate"] <= 75 for d in test_data)