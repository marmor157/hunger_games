import "./app.scss";

import React from "react";
import ReactDOM from "react-dom";

const rootElement = document.getElementById("root");

const Greet = () => <h1 className="App">Hello, world!</h1>;

ReactDOM.render(<Greet />, rootElement);
