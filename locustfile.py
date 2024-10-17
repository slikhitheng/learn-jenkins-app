from locust import HttpUser, task, between

class MyUser(HttpUser):
    host = "https://demo.iqsuite.com"
    wait_time = between(1, 5)  # Wartezeit zwischen Anfragen (in Sekunden)

    @task
    def load_home_page(self):
        self.client.get("/api/gbs/monitor/quarantines/available")  