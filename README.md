# Junk4Dollars iOS app
[![Build Status](https://travis-ci.com/riccjohn/junk4dollars-app.svg?branch=master)](https://travis-ci.com/riccjohn/junk4dollars-app)

## Architecture Decisions

Auctions

Comparing Auctions only checks if the Auction identifier is equal. Auction instances will only ever be created in response to getting data from the API, which guarantees the ID will be different for each auction.

Auctions are considered unique as long as they have a unique identifier. It does not matter if two people create an auction to sell their house and aren't very creative with the name / description and both happen to have the same starting price. The `ends_at` time would likely be different, but the database guarantees us that the id will be unique.
