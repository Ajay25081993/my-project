from app.main import app

def test_home():
    client = app.test_client()
    response = client.get("/")
    assert response.data.decode() == "Hello from Python Docker App on AWS EC2!"
