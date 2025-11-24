# SupportDraken

**SupportDraken** is a local development playground for the entire Draken support ecosystem. It orchestrates all backend microservices, databases, mocks, and the web app—so you can spin up a full stack with a single command.

---

## Features

- **API stack**: All Draken microservices
- **Database**: MariaDB preloaded with test data
- **Mocking**: WireMock for external API stubs
- **Web app**: Frontend & backend from `web-app-draken-public` (built locally)

---

## Requirements

- Docker (or Podman)
- No other dependencies required

---

## Quick Start

Clone and launch everything:

```bash
git clone git@github.com:Sundsvallskommun/SupportDraken.git
cd SupportDraken
./scripts/run.sh
```

---

## Building the Web App Images

SupportDraken builds the public web-app frontend and backend directly from GitHub, injecting your config at build time.

To build images:

```bash
docker compose --profile build run --rm builder
```

The builder will:
1. Clone `web-app-draken-public`
2. Copy config from `config/`
3. Apply custom Dockerfiles
4. Build frontend & backend images

**Config files you control:**

- `config/.env-draken-public-backend`
- `config/.env-draken-public-frontend`
- `config/dockerfiles/Dockerfile-draken-public-backend`
- `config/dockerfiles/Dockerfile-draken-public-frontend`

**Updating config?**
Change the files, then rebuild and restart:

```bash
docker compose --profile build run --rm builder
docker compose up -d
```

---

## Starting & Stopping the Environment

Start all services:

```bash
docker compose up -d
```

Or use the helper script:


```bash
./scripts/run.sh
```

Stop all services:

```bash
./scripts/stop.sh
```

Stop and remove all volumes (reset state):

```bash
./scripts/stop.sh -v
```

---

## Accessing the Web App

- **Frontend:** [http://localhost:3000](http://localhost:3000)
- **Backend:** [http://localhost:3001](http://localhost:3001)

---

## Services & Ports

| Service            | Port | Purpose                             |
|--------------------|------|-------------------------------------|
| nginx proxy        | 8888 | Central reverse proxy for web/app   |
| eventlog           | 8080 | Central event logger                |
| notes              | 8081 | Notes for orgs/citizens             |
| relations          | 8082 | Internal/external relation storage  |
| message-exchange   | 8083 | Internal secure messages            |
| messaging-settings | 8084 | Messaging config per org/department |
| templating         | 8086 | Template rendering + PDF gen        |
| support-management | 8087 | Handles support cases               |
| case-status        | 8088 | Live case status info               |
| party              | 8089 | Maps legalId ↔ partyId              |
| messaging          | 8090 | Sends email/SMS/letters             |
| case-data          | 8091 | Parking/land/exploitation cases     |
| access-mapper      | 8092 | AD → internal access mapping        |
| WireMock           | 9000 | Mock external systems               |
| MariaDB            | 3306 | All databases used by services      |

**MariaDB Databases:**
`relations`, `notes`, `eventlog`, `message_exchange`, `messaging_settings`, `templating`, `support_management`, `case_status`, `messaging`, `case_data`, `case_management`, `access_mapper`

---

## Test Data

Services are preloaded with metadata for a clean boot. To add more data, drop SQL scripts into:

```
config/db
```

---


## Logs & Troubleshooting

> **Note:** If you started the environment using `./scripts/run.sh`, Docker is running inside a container (docker-in-docker). You must run troubleshooting commands inside the `runner` container.

### If you started with `docker compose up -d` (directly on your host):

- Tail all logs:
	```bash
	docker compose logs -f
	```
- Tail a specific service:
	```bash
	docker compose logs -f api-service-support-management
	```
- Check running services:
	```bash
	docker compose ps
	```

### If you started with `./scripts/run.sh` (docker-in-docker):

1. Enter the runner container shell:
	 ```sh
	 docker exec -it supportdraken sh
	 ```
2. Then run compose commands inside the container:
	 ```sh
	 docker compose logs -f
	 docker compose ps
	 ```

---

### Common Issues

**Repo clone fails**
- Check your internet connection
- Ensure you have GitHub access
- Make sure `git` is installed in the builder container

**Frontend won’t load**
- Build may not have completed
- Check `NEXT_PUBLIC_API_URL` in your config
- Remember: `NEXT_PUBLIC_*` variables are injected at **build time**, not runtime

**Environment variables not updating?**
- If you change `config/.env-draken-public-frontend`, you must rebuild the frontend image for changes to take effect

---

## Contributing

Pull requests are welcome! See the shared org guidelines:
[Sundsvallskommun Contribution Guide](https://github.com/Sundsvallskommun/.github/blob/main/.github/CONTRIBUTING.md)

---

## License

This project is licensed under the [MIT License](LICENSE).

© 2025 Sundsvalls kommun
