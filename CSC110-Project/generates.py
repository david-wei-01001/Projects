"""This python module contains classes for generating all entities from the data collected."""

from data_process import process_sea_level_data, process_temperature_data
from climate_sea_level_system import ClimateSeaLevelSystem
from entities import Station, Temperature
from typing import List, Dict, Tuple, Any
import datetime
from statistics import mean
import urllib.request
import csv
import contextlib


class EntityGenerator:
    """An abstract class that generate all entities."""

    def generate(self, system: ClimateSeaLevelSystem) -> None:
        """generating new entities based on the data collected.
       """
        raise NotImplementedError


class GenerateTemperature(EntityGenerator):
    """A class that is responsible for generating temperatures."""

    def generate(self, system: ClimateSeaLevelSystem) -> None:
        """Mutate system by generating temperatures.
        """
        lst_temp = process_temperature_data()
        for temp in lst_temp:
            new_temp = Temperature(temp[0], temp[1])
            system.add_temperature(new_temp)
        print("All temperatures are added")


class GenerateStationAndSeaLevel(EntityGenerator):
    """A class that is responsible for generating station.
    """
    # Private Instance Attributes:
    #   - _processed_sea_level_data: a mapping from a sea level station name
    #       to a list of useful information of that station generated by
    #       process_sea_level_data() function in data_process file
    _processed_sea_level_data: Dict[str, list]

    def __init__(self) -> None:
        """Initialize a new Generate Station object and
        generate its a private attribute _processed_sea_level_data"""
        self._processed_sea_level_data = process_sea_level_data()

    def generate(self, system: ClimateSeaLevelSystem) -> None:
        """Mutate system by generating all stations.

        For now, the number of stations generated is limited to 20.
        If you want to see more, feel free to change it.

        Please note, it takes long to generate more stations.
        """
        station_dict = self._processed_sea_level_data.keys()
        for station in station_dict:
            # Warning: when allowing too many stations to be added, sometimes the
            #          web-browser will time out and nothing will be shown.
            if len(system.get_station()) >= 20:
                break
            location = self._processed_sea_level_data[station][0]
            sea_level = self.process_single_sea_level(station)
            min_height = min(sea_level[0][data] for data in sea_level[0])
            max_height = max(sea_level[0][data] for data in sea_level[0])
            new_station = Station(station, location, sea_level[0], min_height, max_height)
            system.add_station(new_station)
            system.add_sea_level_date(sea_level[1])
            print(f'{station} is added.')

    def process_single_sea_level(self, station: str) -> Tuple[Dict[datetime.date, float], list]:
        """This function will extract sea-level data from the internet.

        This function will extract the corresponding sea-level data of the
        input station name from the internet."""
        csv_web = self._processed_sea_level_data[station][1]

        with contextlib.closing(urllib.request.urlopen(csv_web)) as csv_file:
            lst_line = [line.decode('utf-8') for line in csv_file.readlines()]
        read = csv.reader(lst_line)

        # change the date of each data to datetime.date type
        total_month_time_lst = []
        useful_data_lst = []
        for row in read:
            month = datetime.date(int(row[0]), int(row[1]), 6)
            total_month_time_lst.append(month)

            # filter out outlier data: -32767
            if int(row[3]) >= 0:
                date = datetime.date(int(row[0]), int(row[1]), int(row[2]))
                height = int(row[3])
                useful_data_lst.append([date, height])

        return (self.average(useful_data_lst), total_month_time_lst)

    def average(self, lst: List[List[Any]]) -> Dict[datetime.date, float]:
        """Return a dictionary containing each month of each year that have valid measurements and
                 the average of all measurements during that month."""
        average_dict = {}
        for measure in lst:
            year_month = datetime.date(measure[0].year, measure[0].month, 6)
            if year_month not in average_dict:
                average_dict[year_month] = [measure[1]]
            else:
                average_dict[year_month].append(measure[1])

        for month in average_dict:
            lst = average_dict[month]
            average_dict[month] = mean(lst)

        return average_dict