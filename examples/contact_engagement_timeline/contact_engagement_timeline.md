# Contact engagement timeline

This example builds an engagement timeline for a single HubSpot contact. It first discovers which
event types the authenticated account is allowed to query, then retrieves that contact's most recent
events and aggregates them into a per-event-type breakdown. Finally it reports the paging cursor so
the caller can continue walking further back through the contact's history.

## Prerequisites

### 1. Setup HubSpot developer account

Refer to the [Setup guide](../../ballerina/README.md#setup-guide) to obtain the Client ID, Client
Secret and Refresh Token for a HubSpot app with the `crm.objects.contacts.read` scope.

### 2. Configuration

Create a `Config.toml` file in the example's root directory and provide your credentials:

```toml
clientId = "<Client Id>"
clientSecret = "<Client Secret>"
refreshToken = "<Refresh Token>"
contactId = "<numeric HubSpot contact record ID>"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
