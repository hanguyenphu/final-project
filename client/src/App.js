import React, { Component } from "react";
import "./App.css";
import "./components/ShoppingCart/ShoppingCart";
import ShoppingCart from "./components/ShoppingCart/ShoppingCart";
import { Route, Switch, Router } from "react-router-dom";
import CheckOut from "./components/CheckOut/CheckOut";
import { createBrowserHistory } from "history";

const history = createBrowserHistory();

class App extends Component {
  render() {
    return (
      <Router history={history}>
        <Switch>
          <Route exact path="/" component={ShoppingCart} />
        </Switch>
      </Router>
    );
  }
}

export default App;
