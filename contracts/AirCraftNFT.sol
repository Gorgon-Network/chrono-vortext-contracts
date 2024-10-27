// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract AircraftNFT is ERC721, ERC721Enumerable,  Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Aircraft {
        uint256 points;
        uint256 level;
    }

    mapping(uint256 => Aircraft) public aircrafts;

    event AircraftUpdated(uint256 indexed tokenId, uint256 points, uint256 level);

    // Constructor: Truyền tên, ký hiệu cho ERC721 và người sở hữu ban đầu cho Ownable
    constructor() ERC721("AircraftNFT", "ANFT") {}

    // Override các hàm này theo yêu cầu của OpenZeppelin khi sử dụng ERC721Enumerable
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
    internal
    override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, ERC721Enumerable)
    returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function mintAircraft(address player) public returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        aircrafts[newItemId] = Aircraft({points: 0, level: 1});
        _mint(player, newItemId);

        return newItemId;
    }

    function updateAircraft(uint256 tokenId, uint256 pointsGained) public {
        require(_existsToken(tokenId), "Aircraft does not exist");

        Aircraft storage aircraft = aircrafts[tokenId];
        aircraft.points += pointsGained;

        aircraft.level = (aircraft.points / 100) + 1;

        emit AircraftUpdated(tokenId, aircraft.points, aircraft.level);
    }

    function getAircraftData(uint256 tokenId) public view returns (uint256, uint256) {
        require(_existsToken(tokenId), "Aircraft does not exist");
        Aircraft memory aircraft = aircrafts[tokenId];
        return (aircraft.points, aircraft.level);
    }

    // Sử dụng ownerOf để kiểm tra token có tồn tại hay không
    function _existsToken(uint256 tokenId) internal view returns (bool) {
        try this.ownerOf(tokenId) {
            return true;
        } catch {
            return false;
        }
    }
}
