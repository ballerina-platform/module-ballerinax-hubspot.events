# Tests

The test suite covers both operations exposed by the connector. `listEvents` is exercised twice —
once with no arguments to verify the default event listing, and once with a filtered query
(`objectType`, `objectId`, `occurredAfter`, `limit`, `sort`) to verify query parameter serialisation
and cursor-based paging. `listEventTypes` is exercised to verify the visible event type listing.

Tests run in two modes. By default they execute against the mock server, which requires no
credentials. Setting `IS_LIVE_SERVER=true` runs the same tests against the real HubSpot Events API,
reading the access token from the `HUBSPOT_ACCESS_TOKEN` environment variable.

## Running Tests

```bash
bal test
```

The test suite uses a mock server (`tests/mock_service.bal`) that intercepts HTTP calls so no real credentials are required.

To run against the live API instead:

```bash
export IS_LIVE_SERVER=true
export HUBSPOT_ACCESS_TOKEN="<HubSpot private app access token>"
bal test --groups live_tests
```
