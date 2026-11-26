// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";

final string serviceUrl = isLiveServer ? "https://api.hubapi.com/events/v3" : "http://localhost:9090/events/v3";

final string token = isLiveServer ? os:getEnv("HUBSPOT_ACCESS_TOKEN") : "test_token";

final Client hubspotEvents = check new ({auth: {token}}, serviceUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListEvents() returns error? {
    EventCollection response = check hubspotEvents->listEvents();
    test:assertTrue(response.results.length() > 0, "Expected at least one event in the collection");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListEventsWithQueries() returns error? {
    EventCollection response = check hubspotEvents->listEvents(queries = {
        'limit: 2,
        objectType: "contact",
        occurredAfter: "2026-09-01T00:00:00.000Z"
    });
    test:assertTrue(response.results.length() > 0, "Expected at least one event for the filtered query");
    test:assertTrue(response.paging?.next?.after !is (), "Expected a paging cursor for the next page");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListEventTypes() returns error? {
    EventTypeNames response = check hubspotEvents->listEventTypes();
    test:assertTrue(response.eventTypes.length() > 0, "Expected at least one visible event type");
}
