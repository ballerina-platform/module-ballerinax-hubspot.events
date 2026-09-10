_Author_:  @DimuthuMadushan \
_Created_: 2026/09/10 \
_Updated_: 2026/09/10 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Hubspot.events. 
The OpenAPI specification is obtained from (TODO: Add source link).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Change the `url` property of the servers object
- **Original**: `https://api.hubapi.com`
- **Updated**: `https://api.hubapi.com/events/v3`
- **Reason**: Common prefix added to base URL to simplify endpoint paths.
<!-- auto-generated -->

2. Update the API Paths
- **Original**: Paths included common prefix `/events/v3` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

3. Wire the private app API key into the operation security requirements
- **Original**: `components.securitySchemes` declared four schemes (`developer_hapikey`, `oauth2`, `private_apps`, `private_apps_legacy`), but every operation's `security` listed only `oauth2`.
- **Updated**: Removed the unused `developer_hapikey` and `private_apps_legacy` schemes, and added `private_apps` to each operation's `security` alongside `oauth2`, mirroring the `oauth2` scope list.
- **Note**: `private_apps` (header `private-app`) is paired with `oauth2`, and `private_apps_legacy` (header `private-app-legacy`) with `oauth2_legacy`. Since these operations declare `oauth2`, the non-legacy scheme is the matching one — the same pairing HubSpot uses in the CRM object specs.
- **Caveat**: HubSpot's public documentation describes private app access tokens as being sent via `Authorization: Bearer <token>`, whereas HubSpot's own OpenAPI specs model them as an `apiKey` in the `private-app` header. The scheme is deliberately left as `apiKey` here to match HubSpot's spec and the sibling `hubspot.*` connectors. The `ApiKeysConfig` path is not verified against the live API; `http:BearerTokenConfig` (already on the `auth` union) is the route to prefer for private app tokens.
- **Reason**: The OpenAPI tool derives `ApiKeysConfig` from `components.securitySchemes` but only emits the header-injection code when an operation's `security` names the scheme. Without this change the generated client exposed an `ApiKeysConfig` variant requiring all three keys that was never applied to any request, so selecting it produced silently unauthenticated calls. This matches how sibling HubSpot connectors are shaped.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i ../docs/spec/aligned_ballerina_openapi.json --mode client --license ../docs/license.txt -o ballerina --client-methods remote
```

Note: The license year is hardcoded to 2024, change if necessary.
