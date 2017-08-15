import React from 'react';

import $ from 'jquery';

//Stubbed Test Data
var UserName = 'SuperUser123';
var PassData = [{Passes: 15, StartDate: 'June 3', EndDate: 'June 30', Exclusions: 'Neko Yoga'}, {Passes: 9, StartDate: 'July 6', EndDate: 'July 20', Exclusions: null}];
var UserId = '12345';







class SellPasses extends React.Component {
	constructor(props) {
    super(props);
    this.state = {currentlySelling: null};
  }


componentDidMount() {
  console.log('MOUNTED');




}



  getInfo () {

    console.log('clicked');
    $.ajax({
      url: '/pass/seller/current',
      type: 'POST',
      data: UserId,
      dataType: 'text',
      contentType: 'text/plain',
      success: function(data) {console.log('Posted to local server!');
      getInfoBack(); 
      },
      error: function(data) {console.log('Server Call Failed')}
    })
  }

  getInfoBack () {
    $.ajax({
      url: '/pass/seller/current',
      type: 'GET',
      dataType: 'text',
      contentType: 'text/plain',
      success: function(data) {this.state.currentlySelling = data); 
      },
      error:  function(data) {console.log('getInfoBack Function Failed')}
    })
  }



 

  render () {
    return (
      <div>
        <h2>Add Passes To Sell</h2>
        <AddPasses/>
        <PassList data = {PassData}/>
        <button type="button" onClick = {this.getInfo}>Refresh Information</button>
      </div>
    )
  }
}




//Placeholder For Location To Add New Sales
var AddPasses = () => (
  <div>
  <p>Options to add passes for sale here.</p>
  </div>
)


var PassList = (props) => (
  <div>
    <h2>The Passes You Are Currently Offering For Sale</h2>
    <ul>
      {props.data.map(function (item, i) {
        return <PassBlock BlockData = {item} key = {i}/>
      })}
    </ul>
  </div>  
)



class PassBlock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return (
      <div>
        <li>{this.props.BlockData.Passes} Passes For Dates: {this.props.BlockData.StartDate} - {this.props.BlockData.EndDate} || Exclusions: {this.props.BlockData.Exclusions} <button type="button">Edit This Post</button></li>
        <br />
      </div>
    ) 
  }
}




export default SellPasses;


