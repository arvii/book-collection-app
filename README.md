# Application Name

Briefly introduce your application and what it does. This is a good place to make it clear what the purpose of the application is and any high-level details a user or developer would find useful.

## Requirements

- Ruby 3.2.2
- Docker (for setting up the database environment)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software:

- Install [Ruby 3.2.2](https://www.ruby-lang.org/en/downloads/)
- Install [Docker](https://docs.docker.com/get-docker/)
- Install [Docker Compose](https://docs.docker.com/compose/install/) (usually included with Docker Desktop for Mac and Windows)

### Setup

A step-by-step series of examples that tell you how to get a development environment running:

1. **Clone the repository**
git clone https://github.com/your/repository.git
cd repository

2. **Bundle install**
bundle install(gem install bundler if does not exist)

3. **Build Docker containers**
docker-compose build

4. **Start the application**
docker-compose up


5. **Create and migrate the database**
Open a new terminal tab/window to run:
rails db:create db:migrate

6. **Scrape thestorygraph data**
rails thestorygraph_scrape:scrape

7. **Start the app**
rails s