// Build a contact engagement timeline: discover which event types the account can
// query, then fetch a contact's recent activity and summarise it by event type.

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.events;

// Configuration — create a Config.toml with these values before running
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string contactId = ?;

public function main() returns error? {
    final events:ConnectionConfig config = {
        auth: {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };
    final events:Client hubspotEvents = check new (config);

    // Step 1: Discover the event types this account is allowed to query.
    events:EventTypeNames eventTypes = check hubspotEvents->listEventTypes();
    io:println("Visible event types (", eventTypes.eventTypes.length(), "):");
    foreach string eventType in eventTypes.eventTypes {
        io:println("  - ", eventType);
    }

    // Step 2: Fetch the most recent events recorded against this contact.
    events:EventCollection timeline = check hubspotEvents->listEvents(queries = {
        objectType: "contact",
        objectId: check int:fromString(contactId),
        'limit: 50,
        sort: ["-occurredAt"]
    });

    // Step 3: Summarise the timeline by event type.
    map<int> countsByType = {};
    foreach events:Event event in timeline.results {
        countsByType[event.eventType] = (countsByType[event.eventType] ?: 0) + 1;
    }

    io:println("\nEngagement summary for contact ", contactId, ":");
    io:println("  total events: ", timeline.results.length());
    foreach [string, int] [eventType, count] in countsByType.entries() {
        io:println("  ", eventType, ": ", count);
    }

    // Step 4: Report the paging cursor so the caller can walk older activity.
    string? nextCursor = timeline.paging?.next?.after;
    if nextCursor is string {
        io:println("\nMore activity available — next cursor: ", nextCursor);
    } else {
        io:println("\nEnd of the contact's event history.");
    }
}
