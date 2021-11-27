import "./app.scss";

import { CSSReset, ChakraProvider, ColorModeScript } from "@chakra-ui/react";

import { ApolloProvider } from "@apollo/client";
import { BrowserRouter } from "react-router-dom";
import Index from ".";
import React from "react";
import ReactDOM from "react-dom";
import client from "./graphql/client";
import theme from "./theme";

const rootElement = document.getElementById("root");

const App = () => {
  return (
    <ApolloProvider client={client}>
      <ChakraProvider>
        <BrowserRouter>
          <CSSReset />
          <Index />
        </BrowserRouter>
      </ChakraProvider>
    </ApolloProvider>
  );
};

ReactDOM.render(
  <>
    <ColorModeScript initialColorMode={theme.config.initialColorMode} />
    <App />
  </>,
  rootElement
);
