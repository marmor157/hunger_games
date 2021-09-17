import { ApolloClient, InMemoryCache } from "@apollo/client";

const API_URL = "/api/v1";

const client = new ApolloClient({
  uri: API_URL,
  cache: new InMemoryCache(),
});

export default client;
