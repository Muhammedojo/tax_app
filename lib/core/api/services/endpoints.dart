String get baseUrl => "http://206.189.120.212";

String get baseApi => "$baseUrl/api/v1/";

const languageEndpoint = "meta/languages";
const roleEndpoint = "meta/roles";
const topicEndpoint = "meta/topics";

const lawRegistryEndpoint = "laws/registry";
const lawEndpoint = "laws";
const lawSectionEndpoint = "laws/${2}";

const aiQueryEndpoint = "ai/query";

const offlinePackEndpoint = "offline-pack";

const updateEndpoint = "updates";
const updateFilterEndpoint = "updates/${1}";

const searchEndpoint = "search?q=${'query'}&law_id=${1}";
