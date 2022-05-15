// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LFRNFT is ERC721, ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor(string memory name, string memory symbol)
        ERC721(name, symbol)
    {}

    function mintLFNFT(address promotor, uint256 totalTicket)
        public
        returns (bool)
    {
        for (uint256 i = 1; i <= totalTicket; i++) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _mint(promotor, newItemId);
            _setTokenURI(newItemId, "glitter.json");
        }

        return true;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://raw.githubusercontent.com/2pai/nft-erc721/main/item/";
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}

contract ContractFactory {
    address[] public contracts;
    address public lastContractAddress;

    function getContractCount() public view returns (uint256 contractCount) {
        return contracts.length;
    }

    // deploy a new purchase contract
    function deploy(string memory name, string memory symbol)
        public
        returns (address newContract)
    {
        LFRNFT c = new LFRNFT(name, symbol);
        address cAddr = address(c);
        contracts.push(cAddr);
        lastContractAddress = cAddr;

        return cAddr;
    }

    function mint(LFRNFT tokenAddress, uint256 totalSupply) public {
        tokenAddress.mintLFNFT(msg.sender, totalSupply);
    }
}
