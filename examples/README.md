# Examples

The `ballerinax/hubspot.events` connector provides practical examples illustrating usage in various scenarios.

| Example | Description |
|---------|-------------|
| [`contact_engagement_timeline`](./contact_engagement_timeline/contact_engagement_timeline.md) | Discover the account's queryable event types, then retrieve and summarise a contact's recent activity by event type. |

## Prerequisites

1. Refer to the [Setup guide](../ballerina/README.md#setup-guide) to obtain the Client ID, Client Secret and Refresh Token for a HubSpot app.

2. For each example, create a `Config.toml` file in the example's root directory with the obtained credentials:

   ```toml
   clientId = "<Client Id>"
   clientSecret = "<Client Secret>"
   refreshToken = "<Refresh Token>"
   ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
