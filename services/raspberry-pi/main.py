"""
边缘 AI 健康监护系统 - 主入口文件
"""
import os
import sys
from flask import Flask, jsonify
from flask_cors import CORS
from loguru import logger
import yaml
from dotenv import load_dotenv

# 加载环境变量
load_dotenv()

# 初始化 Flask 应用
app = Flask(__name__)
CORS(app)

# 加载配置文件
def load_config():
    """加载配置文件"""
    config_path = os.path.join(os.path.dirname(__file__), 'config.yaml')
    if os.path.exists(config_path):
        with open(config_path, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)
    return {}

config = load_config()

# 配置日志
logger.remove()
logger.add(
    sys.stdout,
    format="<green>{time:YYYY-MM-DD HH:mm:ss}</green> | <level>{level: <8}</level> | <cyan>{name}</cyan>:<cyan>{function}</cyan> - <level>{message}</level>",
    level="INFO"
)
logger.add("logs/app.log", rotation="500 MB", level="DEBUG")

@app.route('/')
def index():
    """首页"""
    return jsonify({
        "service": "边缘 AI 健康监护系统",
        "version": "1.0.0",
        "status": "running"
    })

@app.route('/api/health')
def health_check():
    """健康检查 API"""
    return jsonify({
        "status": "healthy",
        "service": "tangtang-backend",
        "version": "1.0.0"
    })

@app.route('/api/patients')
def get_patients():
    """获取患者列表"""
    return jsonify({
        "patients": [],
        "total": 0
    })

@app.route('/api/sensors')
def get_sensors():
    """获取传感器状态"""
    return jsonify({
        "sensors": [],
        "total": 0
    })

@app.route('/api/vitals')
def get_vitals():
    """获取生命体征数据"""
    return jsonify({
        "vitals": [],
        "total": 0
    })

if __name__ == '__main__':
    logger.info("启动边缘 AI 健康监护系统...")
    logger.info(f"配置文件：{config}")
    
    # 创建日志目录
    os.makedirs('logs', exist_ok=True)
    os.makedirs('data', exist_ok=True)
    
    # 启动服务
    port = int(os.getenv('PORT', 8080))
    app.run(host='0.0.0.0', port=port, debug=os.getenv('FLASK_DEBUG', 'false').lower() == 'true')