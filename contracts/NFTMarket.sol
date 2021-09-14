// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @author tbtstl & gzork
/// @title A Simple NFT Market
contract NFTMarket {

    struct listedNftToken {
        address owner;
        uint256 price;
    }

    struct listedNft {
        mapping(uint256 => listedNftToken) tokens;
        mapping(uint256 => uint256) indexOfToken;
        uint256[] tokensArray;
        uint256[] floorTokens;
        uint256 floorPrice;
        bool active;
    }

    mapping(address => listedNft) private listedNfts;
    address[] private listedNftsArray;

    // This function can be very costly to execute depending on the size of the NFT listing
    // This means it wouldn't scale well so the goal is to keep its usage to a minimum
    // and to find a more efficient approach
    function buildFloor(address _nftAddress) internal {
        if (listedNfts[_nftAddress].tokensArray.length > 1) {
            for (uint256 i = 0; i<listedNfts[_nftAddress].tokensArray.length-1; i++){
                if (listedNfts[_nftAddress].floorPrice == 0 || listedNfts[_nftAddress].tokens[listedNfts[_nftAddress].tokensArray[i]].price < listedNfts[_nftAddress].floorPrice) {
                    listedNfts[_nftAddress].floorPrice = listedNfts[_nftAddress].tokens[listedNfts[_nftAddress].tokensArray[i]].price;
                    delete listedNfts[_nftAddress].floorTokens;
                    listedNfts[_nftAddress].floorTokens.push(listedNfts[_nftAddress].tokensArray[i]);
                } else if (listedNfts[_nftAddress].tokens[listedNfts[_nftAddress].tokensArray[i]].price == listedNfts[_nftAddress].floorPrice) {
                    listedNfts[_nftAddress].floorTokens.push(listedNfts[_nftAddress].tokensArray[i]);
                }
            }
        } else if (listedNfts[_nftAddress].tokensArray.length == 1) {
            delete listedNfts[_nftAddress].floorTokens;
            listedNfts[_nftAddress].floorTokens = listedNfts[_nftAddress].tokensArray;
            listedNfts[_nftAddress].floorPrice = listedNfts[_nftAddress].tokens[listedNfts[_nftAddress].tokensArray[0]].price;
        } else {
            delete listedNfts[_nftAddress].floorTokens;
            listedNfts[_nftAddress].floorPrice = 0;
        }
    }

    function _removeArrayItem(uint256 _index, uint256[] storage _array) internal returns (uint256[] memory) {
        if (_index >= _array.length) return _array;
        if (_array.length > 1) {
            for (uint256 i = _index; i<_array.length-1; i++){
                _array[i] = _array[i+1];
            }
        }
        delete _array[_array.length-1];
        _array.pop();
        return _array;
    }

    function removeTokensArrayItem(address _nftAddress, uint256 _tokenID) internal {
        listedNfts[_nftAddress].tokensArray = _removeArrayItem(listedNfts[_nftAddress].indexOfToken[_tokenID], listedNfts[_nftAddress].tokensArray);
        delete listedNfts[_nftAddress].indexOfToken[_tokenID];
    }

    /// List an NFT for sale.
    /// @param _nftAddress the address of the NFT contract
    /// @param _tokenID the token ID for the NFT being sold
    /// @param _amount the amount in wei to sell the NFT for
    function list(address _nftAddress, uint256 _tokenID, uint256 _amount) public {
        // TODO: Implement this function!
    }

    /// Purchase a specified NFT
    /// @param _nftAddress the address of the NFT contract
    /// @param _tokenID the token ID for the NFT being sold
    function purchase(address _nftAddress, uint256 _tokenID) public payable {
        // TODO: Implement this function!
    }

    /// Return the lowest listed NFT for sale in a given collection
    /// @param _nftAddress the address of the NFT contract
    function getFloorPrice(address _nftAddress) public returns (uint256) {
        // TODO: Implement this function!

        return 1;
    }

    /// Purchase the cheapest NFT in a specified collection.
    /// @param _nftAddress the address of the NFT contract
    function buyFloor(address _nftAddress) public payable {
        // TODO: Implement this function!
    }
}