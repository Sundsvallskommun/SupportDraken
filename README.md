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
    ./run.sh
    ```

## Default Test-Data
  By default some test-data is inserted to some of the databases, primarilty metadata. The purpose of this is to have simple basic version that is runnable with minimal effort. 

  If you need to add more test-data, insert scripts can be added/modified. 
  The scripts can be found at:
  ```bash
  cd /SupportDraken/config/mockdata
  ```
## Available Scripts

1. **Start the service**
   ```bash
   ./run.sh
   ./run.sh -f (forces rebuild of local images) 
   ```

2. **Stop the service**
   ```
   ./stop.sh
   ./stop.sh -v (removes volumes)
   ```

## Services, ports and descriptions ## 
  SupportDraken consists of multiple services which are configured to run on its own port.

1. **api-service-eventlog**

  _Eventlog that acts as a centralized event logging system. It receives and stores events from various services within the ecosystem, enabling other services to query and retrieve event data. This service provides a way to track, store, and access event logs across different applications._
  ```
   Eventlog runs on port 8080.
  ```

2. **api-service-notes**

  _Notes provides functionality for storing and retrieving notes linked to an organization or a citizen._
  ```
   Notes runs on port 8081.
  ```

3. **api-service-relations**

  _Relations stores relations between internal and external resources._
  ```
   Relations runs on port 8082.
  ```

4. **api-service-message-exchange**

  _MessageExchange is dedicated to storing and retrieving internal messages securely. It enables authorized stakeholders to access relevant communications, serving as the central hub for internal interactions._
  ```
   MessageExchange runs on port 8083.
  ```

5. **api-service-messaging-settings**

  _MessagingSettings stores messaging configuration for organizations and departments._
  ```
   MessagingSettings runs on port 8084.
  ```

6. **api-service-templating**

  _Templating provides functionality for storing and rendering templates. It supports rendering templates into various text-based formats such as HTML and plain text, as well as converting them into PDF documents._
  ```
   Templating runs on port 8086.
  ```

7. **api-service-support-management**

  _SupportManagement provides features for managing cases related to support related functions. It includes functionalities such as creating, updating, and tracking errand statuses and progress._
  ```
   SupportManagment runs on port 8087.
  ```

8. **api-service-case-status**

  _CaseStatus provides updated status information about cases in underlying systems, ensuring that users are always informed about the current state and progress of their cases._
  ```
   CaseStatus runs on port 8088.
  ```

9. **api-service-party**

  _Party is a proxy service for the underlying citizen and legalentity services, with the aim of simplifying for clients who need to translate between legalId and partyId for individuals or organizations._
  ```
   Party runs on port 8089.
  ```

10. **api-service-case-data**

  _CaseData manages cases primarily related to citizen-related subjects. Handles cases for parking permits and cases related to land and exploitation subjects._
  ```
   CaseData runs on port 8091.
  ```

11. **api-service-access-mapper**

  _AccessMapper serves as a bridge between the Active Directory service and internal systems, managing access mappings and translating Active Directory groups into corresponding internal access groups._
  ```
   AccessMapper runs on port 8092.
  ```

12. **api-service-messaging**

  _Messaging is used to send different type of messages, such as emails, text messages and letters._
  ```
   Messaging runs on port 8090.
  ```

13. **Wiremock**

  _WireMock is a library for stubbing and mocking web services. It constructs an HTTP server that we can connect to as we would to an actual web service._
  ```
   Wiremock runs on port 9000.
  ```

14. **MariaDB**

  _MariaDB Server is one of the most popular open source relational databases._
  ```
   MariaDB runs on port 3306.
  ```

  Multiple of the service requires their own database which is ran in this instance of MariaDB.
  ```
  Databases:
  - relations
  - notes
  - eventlog
  - message_exchange
  - messaging_settings
  - templating
  - support_management
  - case_status
  - messaging
  - case_data
  - case_management
  - access_mapper
  ```

## Contributing

Contributions are welcome! Please
see [CONTRIBUTING.md](https://github.com/Sundsvallskommun/.github/blob/main/.github/CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the [MIT License](LICENSE).

© 2025 Sundsvalls kommun
