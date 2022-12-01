"""Creates a ClimateSeaLevelSystem that keep tracks of all entities created."""
import datetime
from typing import Dict

# This is the Python module containing the individual entity data classes.
from entities import Temperature, Station


class ClimateSeaLevelSystem:
    """A system that maintains all entities (temperature, station, and sea-level).

    Representation Invariants:
        - all(name == self._stations[name].name for name in self._stations)
    """
    # Private Instance Attributes:
    #   - _temperatures: a mapping from the date when a measure of the global
    #       temperature is made to the measurement.
    #       This represents all the temperatures in the system.
    #   - _stations: a mapping from station name to Station object.
    #       This represents all the stations in the system.
    #   - _sea_level_dates: A set of all dates associated with each sea level measurement.

    _temperatures: Dict[datetime.date, Temperature]
    _stations: Dict[str, Station]
    _sea_level_dates: set

    def __init__(self) -> None:
        """Initialize a new climate sea level system.

        The system starts with no entities.
        """
        self._temperatures = {}
        self._stations = {}
        self._sea_level_dates = set()

    def get_temp(self) -> dict:
        """Return the dict contains all temperature measurements."""
        return self._temperatures

    def get_station(self) -> dict:
        """Return the dict contains all stations."""
        return self._stations

    def get_dates(self) -> set:
        """Return the set containing all dates associated with sea level measurement."""
        return self._sea_level_dates

    def add_temperature(self, temperature: Temperature) -> None:
        """Add the given temperature to this system.

        Do NOT add the temperature if one with the same date already exists.
        """
        identifier = temperature.date
        if identifier not in self._temperatures:
            self._temperatures[identifier] = temperature

    def add_station(self, station: Station) -> None:
        """Add the given station to this system.

        Do NOT add the station if one with the same name already exists.
        """
        identifier = station.name
        if identifier not in self._stations:
            self._stations[identifier] = station

    def add_sea_level_date(self, date_list) -> None:
        """Add dates in given date list to the system."""
        for date in date_list:
            self._sea_level_dates.add(date)
