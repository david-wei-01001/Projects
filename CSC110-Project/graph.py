"""This python module contains all functions needed to draw the animation graph."""
import plotly.graph_objects as go
from climate_sea_level_system import ClimateSeaLevelSystem
from entities import Station
import datetime


def get_color(start_date: datetime.date, station: Station, height: float, ) -> str:
    """Return the colour representing the level of increasing/decreasing of the
    measured sea level at a station"""
    station_start_date = min([date for date in station.sea_level.keys() if date >= start_date])
    starting_height = station.sea_level[station_start_date]
    colors = ['blue', 'red']
    if height <= starting_height:
        return colors[0]
    else:
        return colors[1]


def get_ocean_color(system: ClimateSeaLevelSystem, start_date: datetime.date, current_date: datetime.date):
    """Return the colour representing the level of increasing/decreasing of the
    temperature anomaly at a given time"""
    colors = ['LightBlue', 'lightpink']
    starting_temp_change = system.get_temp()[start_date].temperature
    if current_date in system.get_temp():
        temperature = system.get_temp()[current_date].temperature
    else:
        temperature = system.get_temp()[max(system.get_temp())].temperature
    if temperature <= starting_temp_change:
        return colors[0]
    else:
        return colors[1]


def graph_data_set_up(system: ClimateSeaLevelSystem) -> tuple:
    """Set up all the data for drawing the animation graph.

    It set up the color, location, name, and dates of each station as well as
    the total number of stations and land color."""
    dates = []
    x = []
    y = []
    station_color = []
    ocean_color = []
    station_name = []
    num_station = len(system.get_station())

    # The started year of our animation has been set to 40 years ago (480 months ago)
    # You can change this if you like.
    # Warning: when allowing too many years are processed, sometimes the
    #          web-browser will time out and nothing will be shown.
    date_list = sorted(system.get_dates())[-480:]
    starting_date = date_list[0]

    for date in date_list:
        dates.append(f'{date.year}-{date.month}')
        inner_lst = []
        for station in system.get_station():
            station_obj = system.get_station()[station]
            lon = station_obj.location[0]
            la = station_obj.location[1]
            if date not in station_obj.sea_level:
                color = 'white'
            else:
                color = get_color(starting_date, station_obj, station_obj.sea_level[date])
            x.append(la)
            y.append(lon)
            station_name.append(f'Name of station: {station}')
            inner_lst.append(color)
        station_color.append(inner_lst)
        ocean_color.append(get_ocean_color(system, starting_date, date))
    return (num_station, station_color, ocean_color, dates, x, y, station_name)


def draw_figure(tup: tuple) -> None:
    """The function to draw the animation graph."""
    num_station, station_color, ocean_color, dates, x, y, station_name = tup
    fig_dict = {
        "data": [],
        "layout": {},
        "frames": []
    }

    sliders_dict = {
        "active": 0,
        "yanchor": "top",
        "xanchor": "left",
        "currentvalue": {
            "font": {"size": 20},
            "prefix": "Year and Month:",
            "visible": True,
            "xanchor": "right"
        },
        "transition": {"duration": 300, "easing": "cubic-in-out"},
        "pad": {"b": 10, "t": 50},
        "len": 0.9,
        "x": 0.1,
        "y": 0,
        "steps": []
    }

    fig = go.Scattergeo(lat=x[0:num_station], lon=y[0:num_station], mode='markers',
                        marker={'color': station_color[0]}, hovertext=station_name)

    fig_dict["data"].append(fig)
    fig_dict["layout"]["geo"] = {'showland': True, 'showocean': True, 'landcolor': "burlywood",
                                 'oceancolor': "LightBlue"}
    fig_dict["layout"]["sliders"] = [sliders_dict]
    fig_dict["layout"]["title_text"] = f'Global Sea Level and Temperature Data'

    # make frames
    for i in range(len(dates)):

        fig = go.Scattergeo(lat=x[num_station * i: num_station * i + num_station],
                            lon=y[num_station * i: num_station * i + num_station],
                            mode='markers', marker={'color': station_color[i]},
                            hovertext=station_name)
        frame = {"data": fig, 'name': dates[i], 'layout': {'geo': {'oceancolor': ocean_color[i]}}}

        fig_dict["frames"].append(frame)

        slider_step = {"args": [[dates[i]],
                                {"frame": {"duration": 30, "redraw": True},
                                 "mode": "immediate",
                                 "transition": {"duration": 30}}],
                       "label": dates[i],
                       "method": "animate"}
        sliders_dict["steps"].append(slider_step)

    fig = go.Figure(fig_dict)
    fig.show()


def go_figure(system: ClimateSeaLevelSystem) -> None:
    """It draw the linear regression of the input station.

    The function that integrate all functions in this python module.
    """
    data = graph_data_set_up(system)
    draw_figure(data)
