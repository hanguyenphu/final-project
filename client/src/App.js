import React from "react";
import "./App.css";
import "./components/ShoppingCart/ShoppingCart";
import ShoppingCart from "./components/ShoppingCart/ShoppingCart";
import { Route, Switch } from "react-router";


function App() {
  return (
    <Switch>
      <Route exact path="/">
        <ShoppingCart />
      </Route>
    </Switch>
  );
}

export default App;
