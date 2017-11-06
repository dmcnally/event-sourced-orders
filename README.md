[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/ryantownsend/event-sourced-orders)

### Setup

1. Deploy to Heroku
2. Attach Kafka
3. Add the Postgres addon
3. Create consumer group `heroku kafka:consumer-groups:create orders-order-consumer --app ...`
