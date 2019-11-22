import React, { Component } from "react";
import LeftNav from "../LeftNav/LeftNav";
import Loading from "../Loading/Loading";
import { Redirect } from "react-router";

class ShoppingCart extends Component {
  constructor(props) {
    super(props);
    this.state = {
      features: [],
      quality: [],
      total: 0,
      updateData: false
    };
  }

  componentDidMount() {
    if (!this.state.updateData) {
      this.getFeatures();
    }
  }

  getFeatures() {
    fetch("/shopping_cart/index")
      .then(response => response.json())
      .then(data => {
        this.setState({
          features: data.data.feature,
          quality: data.data.quality,
          authenticated: data.data.authenticated,
          updateData: true
        });
        this.getSubTotal();
      })
      .catch(error => console.log(error));
  }

  getSubTotal() {
    const { features, quality } = this.state;
    let subTotal = 0.0;
    const tax = 0.13;
    const GST = 0.05;
    const PST = 0.08;
    const HST = 0.0;
    features.map(feature => {
      subTotal = subTotal + feature.price * quality[feature.id];
    });
    this.setState({
      subTotal: subTotal,
      total: subTotal + tax * subTotal
    });
  }

  handleChange = featureId => event => {
    let quality = this.state.quality;
    quality[featureId] = event.target.value;
    this.setState({
      quality
    });
  };

  handleCheckOutButton = event => {
    const {history} = this.props
    if (!this.state.authenticated) {
      window.location = "http://localhost:3000/users/sign_in";
    } else {
     console.log('Authenticated');
    }
  };

  handleRemove = id => event => {
    event.preventDefaul
   fetch(`http://localhost:3000/remove_from_cart/${id}`, {
     method: "delete"
   }).then(response => console.log(response))
  }

  displayFeatures() {
    const { features, quality } = this.state;
    if (features.length == 0) {
      return <div>Your Cart is empty!</div>;
    }
    return features.map(feature => {
      return (
        <li key={feature.id}>
          <div className="mdl-grid ">
            <div className="mdl-cell mdl-cell--3-col">{feature.name}</div>

            <div className="mdl-cell mdl-cell--3-col">
              <label htmlFor={feature.id}>Quality: </label>
              <input
                type="number"
                id={feature.id}
                name={feature.id}
                value={this.state.quality[feature.id]}
                onChange={this.handleChange(feature.id)}
              />
            </div>

            <div className="mdl-cell mdl-cell--2-col">
              Price: ${feature.price * quality[feature.id]}
            </div>

            <div className="mdl-cell mdl-cell--2-col">
              <form method="POST" action="/remove_from_cart">
                <input type="hidden" value={feature.id} name="id"/>
                  <button type="submit" className="mdl-button mdl-js-button mdl-button--raised"  >
                    Remove
                  </button>
              </form>

            </div>
          </div>
        </li>
      );
    });
  }

  render() {

    if (!this.state.quality || !this.state.features) {
      return <Loading />;
    } else {
      return (
        <div className="mdl-layout mdl-js-layout mdl-layout--fixed-drawer">
          <LeftNav authenticated={this.state.authenticated} />
          <main
            className="mdl-layout__content"
            style={{ paddingLeft: "30px", paddingTop: "50px" }}
          >
            <div className="page-content">
              <h1>Shopping Cart</h1>

              <ol>{this.displayFeatures()}</ol>
              <button
                className="mdl-button mdl-js-button mdl-button--raised mdl-button--accent"
                onClick={this.handleCheckOutButton}
              >
                Check out
              </button>

            </div>
          </main>
        </div>
      );
    }
  }
}

export default ShoppingCart;
