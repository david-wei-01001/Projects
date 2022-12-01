"""This python module contains all functions needed for extracting data from the internet and process these data."""
from typing import List, Any, Dict
from bs4 import BeautifulSoup
import requests
from datapackage import Package


def get_sea_level_data() -> List[List[str]]:
    """Return a list of sea level information extracted from the website we found.
    The url of the website is http://uhslc.soest.hawaii.edu/data/fd.html"""
    r = requests.get('http://uhslc.soest.hawaii.edu/data/fd.html').text
    soup = BeautifulSoup(r, features="html.parser")
    info = soup.find_all('td')

    # every 12 element in info is a line of data in the website
    info_lst = []
    for i in range(len(info) // 12):
        new_l = []
        for j in range(0, 8):
            new_l.append(info[i * 12 + j].text)
        new_l.append(info[i * 12 + 9].find_all('a')[0].get('href'))
        info_lst.append(new_l)
    return info_lst


def process_sea_level_data() -> Dict[str, list]:
    """Return a dictionary of useful sea level data
    where each key is a station name and each value is a list whose first element
    is a tuple of the station's latitude and longitude and second element is a csv url
    that contains all the sea level data at that station
    """
    all_data = get_sea_level_data()
    useful_data = {}
    for data in all_data:

        # filter out sea-level data that started recording after year 1980
        if int(data[6][:4]) < 1980:
            # store the latitude, longitude and csv url of each list of
            # sea level data in useful_data dictionary
            location_and_url = [(float(data[5]), float(data[4])), data[8]]
            useful_data[data[2]] = location_and_url
    return useful_data


def process_temperature_data() -> List[List[Any]]:
    """Return a list of Global component of Climate at a Glance (GCAG) data
    extracted from the website we found.
    The url of the website is https://datahub.io/core/global-temp/datapackage.json"""
    package = Package('https://datahub.io/core/global-temp/datapackage.json')
    temp_lst = []

    # get monthly temperature csv data
    for resource in package.resources:
        if resource.descriptor['name'] == 'monthly_csv':
            temp_raw_lst = resource.read()
            temp_lst = [temp_raw_lst[i][1:] for i in range(0, len(temp_raw_lst)) if i % 2 == 0]

    # change the temperature in temp_lst to float type
    for data in temp_lst:
        data[1] = float(data[1])

    return temp_lst
