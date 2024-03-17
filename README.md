# Book Collection App

The Book Collection App is a modern application designed to help users curate and manage their personal library collections digitally.

## Requirements

- Ruby 3.2.2
- Docker (for setting up the database environment)
- yarn

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software:

- Install [Ruby 3.2.2](https://www.ruby-lang.org/en/downloads/)
- Install [Docker](https://docs.docker.com/get-docker/)
- Install [Docker Compose](https://docs.docker.com/compose/install/) (usually included with Docker Desktop for Mac and Windows)
- Install [yarn](https://yarnpkg.com/) (You can install yarn via npm (comes with Node.js) by running npm install --global yarn in your terminal.)

### Setup

A step-by-step series of examples that tell you how to get a development environment running:

1. **Clone the repository**
```bash
git clone https://github.com/arvii/book-collection-app.git
```
```bash
cd book-collection-app
```

2. **Bundle install**
(gem install bundler if does not exist)
```bash
bundle install
```
3. **Build Docker containers**
```bash
docker-compose build
```

4. **Start the application**
```bash
docker-compose up
```

5. **Create and migrate the database**
Open a new terminal tab/window to run:
```bash
rails db:create db:migrate
```

6. **Scrape thestorygraph data**
```bash
rails thestorygraph_scrape:scrape
```

7. **Precompile Assets**
```bash
rails assets:precompile
```

8. **Start the app**
```bash
rails s
```

9. **Access the site**
```bash
http://localhost:3000/
```

