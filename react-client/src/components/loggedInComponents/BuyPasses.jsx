import React from 'react';
import $ from 'jquery';
import BuyPassesList from './BuyPassesList.jsx';
import BuyPassesSearch from './BuyPassesSearch.jsx';

class BuyPasses extends React.Component {
	constructor(props) {
    super(props);
    this.state = {
      userEmail: 'billy@bob.com',
      forSaleBlocks: []
    };
  }

  updateForSaleBlocks(forSaleBlocks) {
    var newState = Object.assign({}, this.state);
    newState.forSaleBlocks = forSaleBlocks;
    this.setState(newState);
  }

  handleSearch(searchQueries) {
    var context = this;
    searchQueries.ignoreEmail = this.state.userEmail;
    $.ajax({
      method: 'POST',
      url: '/pass/buyer/search',
      contentType: 'application/json',
      data: JSON.stringify({searchQueries: searchQueries}),
      success: function(forSaleBlocks) {
        context.updateForSaleBlocks(JSON.parse(forSaleBlocks));
      }
    });
  }

  componentDidMount() {
    this.handleSearch({});
  }

  render () {
    return (
      <div>
        <h1>Passes For Sale</h1>
        <BuyPassesSearch handleSearch={this.handleSearch.bind(this)}/>
        <BuyPassesList forSaleBlocks={this.state.forSaleBlocks}/>
      </div>
    )
  }
}

export default BuyPasses;