import "./app.scss";

import { ApolloProvider } from "@apollo/client";
import React from "react";
import ReactDOM from "react-dom";
import client from "./graphql/client";
import { useGetSystemStatusQuery } from "./graphql/index";

const rootElement = document.getElementById("root");

const Greet = () => {
  const { data } = useGetSystemStatusQuery();
  console.log(data);

  return <h1 className="App">Hello, world!</h1>;
};

ReactDOM.render(
  <ApolloProvider client={client}>
    <Greet />
  </ApolloProvider>,
  rootElement
);
