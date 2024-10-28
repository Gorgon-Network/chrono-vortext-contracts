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

    constructor() ERC721("AircraftNFT", "ANFT") {}


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


    function _existsToken(uint256 tokenId) internal view returns (bool) {
        try this.ownerOf(tokenId) {
            return true;
        } catch {
            return false;
        }
    }

    // Struct to store achievement details
    struct Achievement {
        uint256 points;          // Number of points earned
        string description;      // Description of the achievement
        uint256 timestamp;       // Timestamp of the achievement
    }

    // Mapping of user addresses to their list of achievements
    mapping(address => Achievement[]) public playerAchievements;

    // Event to be emitted when a new achievement is recorded
    event AchievementRecorded(address indexed player, uint256 points, string description, uint256 timestamp);

    // Function to record an achievement for a player
    function recordAchievement(uint256 _points, string memory _description) public {
        // Create a new achievement
        Achievement memory newAchievement = Achievement({
            points: _points,
            description: _description,
            timestamp: block.timestamp
        });

        // Add the achievement to the player's list
        playerAchievements[msg.sender].push(newAchievement);

        // Emit an event for the achievement
        emit AchievementRecorded(msg.sender, _points, _description, block.timestamp);
    }

    // Function to get the number of achievements of a player
    function getAchievementCount(address _player) public view returns (uint256) {
        return playerAchievements[_player].length;
    }

    // Function to get a specific achievement of a player by index
    function getAchievement(address _player, uint256 _index) public view returns (uint256, string memory, uint256) {
        Achievement memory achievement = playerAchievements[_player][_index];
        return (achievement.points, achievement.description, achievement.timestamp);
    }
}
