import React, {Component} from 'react';
import LeftNav from "../LeftNav/LeftNav";
class Loading extends Component {

    render() {
        return ( 
            <div className="mdl-layout mdl-js-layout mdl-layout--fixed-drawer">
            <LeftNav authenticated={false}/>
            <main style={{margin: "0px auto", marginTop: "400px",  }}>
            <div className='lds-ellipsis'>
               <div></div>
               <div></div>
               <div></div>
               <div></div>
           </div>
            </main>
          
       </div>
        )
    }
}

export default Loading;