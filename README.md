# SupportDraken

_Package of all services needed to run SupportDraken. Includes scripts for starting docker containers._

## Getting Started

1. **Clone Repository**
   ```bash
     git clone git@github.com:Sundsvallskommun/SupportDraken.git
     cd SupportDraken
   ```
2. **Configure Services**

   Before running the application, you need to ensure that all required configurations are set; otherwise, the application may fail to start.
   
     *Required configurations:*
    - Nothing yet!

3. **Run Service:**
    ```bash
    cd SupportDraken
    ./start-all.sh
    ```

## Default Test-Data
  By default some test-data is inserted to some of the databases, primarilty metadata. The purpose of this is to have simple basic version that is runnable with minimal effort. 

  If you need to add more test-data, insert scripts can be added/modified. 
  The scripts can be found at:
  ```bash
  cd /SupportDraken/seeder/sql
  ```
## Available Scripts

1. **Start the service**
   ```bash
   ./start-all.sh
   ```
3. **Stop the service**
   ```bash
   Stops all docker containers.
   ./stop-all.sh

   Stops all docker containers and removes all volumes.(Database data will be wiped)
   ./stop-all.sh -v
   ```
5. **Pull new images**
   ```bash
   If new versions of the services are released and you want to ensure you are running the latest versions.
   ./pull-all.sh
   ```

## Contributing

Contributions are welcome! Please
see [CONTRIBUTING.md](https://github.com/Sundsvallskommun/.github/blob/main/.github/CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the [MIT License](LICENSE).

© 2025 Sundsvalls kommun
