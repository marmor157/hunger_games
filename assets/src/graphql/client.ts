import { ApolloClient, InMemoryCache, createHttpLink } from "@apollo/client";

import { AUTH_TOKEN } from "../consts";
import { setContext } from "@apollo/client/link/context";

const API_URL = "/api/v1";

const httpLink = createHttpLink({ uri: API_URL });

const authLink = setContext((_, { headers }) => {
  const token = localStorage.getItem(AUTH_TOKEN);

  return {
    headers: {
      ...headers,
      Authorization: token ? `Bearer ${token}` : "",
    },
  };
});

const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache(),
  defaultOptions: {
    mutate: { errorPolicy: "all" },
    query: { errorPolicy: "all" },
    watchQuery: { errorPolicy: "all" },
  },
});

export default client;
