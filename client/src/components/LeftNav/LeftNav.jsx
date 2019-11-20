import React, { Component } from "react";

class LeftNav extends Component {

    constructor(props){
        super(props);

    }


    handleSignOut = (event) => {
        event.preventDefault();
        fetch("/users/sign_out", {method: "DELETE",  headers: {
            'x-csrf-token': "ihwlaOLL232ipKmWYaqbSZacpJegQqooJ+Cj9fLF2e02NTQw7P/MfQyRuzruCax2xYWtEHWsb/uqiiZP6NWH+Q==",
            'content-type': 'application/json',
            'accept': 'application/json'
          }}).then((response)=>{
            console.log(response);
        }).then((result)=> {
            console.log(result);
        })
    }

    render() {
        const {authenticated} = this.props;
        let loginLink = (
                <a className="mdl-navigation__link" href="http://localhost:3000/users/sign_in" >
                    <i className="material-icons" >person</i>
                    Login
                </a>
        );

        if(authenticated) {
            loginLink = (
                <div>
                      <a className="mdl-navigation__link" href="" >
                        <i className="material-icons" >history</i>
                        Order History
                    </a>

                    <a className="mdl-navigation__link" href="http://localhost:3000/users/sign_out"  onClick={this.handleSignOut}>
                        <i className="material-icons" >power_settings_new</i>
                        Log out
                    </a>
                </div>
            )
        }



        return (
            <div className='mdl-layout__drawer'>
                <span className='mdl-layout-title'>Beeblee</span>
                <nav className='mdl-navigation'>
                    <a
                        className='mdl-navigation__link'
                        href='http://localhost:3000/about/index'
                    >
                        <i className='material-icons'>home</i> Home
                    </a>
                    <a
                        className='mdl-navigation__link'
                        href='http://localhost:3000/feature/index'
                    >
                        {" "}
                        <i className='material-icons'>view_list</i> Products
                    </a>
                    <a
                        className='mdl-navigation__link'
                        href='http://localhost:3000/category/index'
                    >
                        <i className='material-icons'>category</i> Categories
                    </a>
                    <a
                        className='mdl-navigation__link'
                        href='http://localhost:3000/contact/index'
                    >
                        {" "}
                        <i className='material-icons'>
                            perm_contact_calendar
                        </i>{" "}
                        Contact Us
                    </a>

                    {loginLink}

                </nav>
            </div>
        );
    }
}

export default LeftNav;
