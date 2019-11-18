import React, { Component } from "react";
import LeftNav from "../LeftNav/LeftNav";
import Loading from "../Loading/Loading";

class ShoppingCart extends Component {
    constructor(props) {
        super(props);
        this.state = {
            features: [],
            quality: [],
            total: 0,
            updateData:false
        };
       
    }

    componentDidMount() {
        if(!this.state.updateData){
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
                    updateData:true
                });
                this.getSubTotal();
            })
            .catch(error => console.log(error));
    }

    getSubTotal() {
        const { features, quality } = this.state;
        let subTotal = 0.00;
        const tax = 0.13;
        const GST = 0.05;
        const PST = 0.08;
        const HST = 0.00;
        features.map(feature => {
            subTotal = subTotal + feature.price * quality[feature.id];
        });
        this.setState({
            subTotal: subTotal,
            total: subTotal + tax*subTotal
        });
    }

    handleChange = (featureId) => ( event) => {
        let quality = this.state.quality;
        quality[featureId] = event.target.value;
        this.setState({
           quality
        })
    }

    displayFeatures() {
        const { features, quality } = this.state;
        return features.map(feature => {
            return (
                <li key={feature.id}>
                    <div className='mdl-grid '>
                        <div className='mdl-cell mdl-cell--3-col'>
                            {feature.name}
                        </div>

                        <div className='mdl-cell mdl-cell--3-col'>
                            <label htmlFor={feature.id}>Quality:</label>
                            <input
                                type='number'
                                id={feature.id}
                                name={feature.id}
                                value={this.state.quality[feature.id]}
                                onChange = {this.handleChange(feature.id)}
                            />
                        </div>

                        <div className='mdl-cell mdl-cell--2-col'>
                            Price: ${feature.price * quality[feature.id]}
                        </div>
                    </div>
                </li>
            );
        });
    }

    render() {
        console.log(this.state.quality);
        if (!this.state.quality || !this.state.features) {
            return (
               <Loading />
            );
        } else {
            return (
                <div className="mdl-layout mdl-js-layout mdl-layout--fixed-drawer">
                     <LeftNav authenticated={this.state.authenticated}/>
                <main
                    className='mdl-layout__content'
                    style={{ paddingLeft: "30px", paddingTop: "50px" }}
                >
                    <div className='page-content'>
                        <h1>Shopping Cart</h1>

                        <ol>{this.displayFeatures()}</ol>
                        <div className='mdl-grid'>
                            <div className='mdl-cell mdl-cell--3-col'></div>
                            <div className='mdl-cell mdl-cell--3-col'></div>
                            <div className='mdl-cell mdl-cell--3-col'>
                                    <p>Subtotal: ${this.state.subTotal}</p>
                                    <p>GST (5%): ${this.state.subTotal*0.05}</p>
                                    <p>PST (8%): ${this.state.subTotal*0.08}</p>
                                    <p>HST (0%): ${this.state.subTotal*0}</p>
                                    <p>Total: ${this.state.total}</p>
                            </div>
                        </div>
                    </div>
                </main>
                </div>
            );
        }
    }
}

export default ShoppingCart;
