# PostGIS examples: MGUG 2019 conference
A mini tutorial on some basic GIS transformations using PostGIS functions.
This was presented at the 2019 Manitoba GIS user Group conference in Winnipeg.

Exercise 1:<br>
Transform vector data using Postgis

We will see how to take a vector file of electoral bounaries of the province of Manitoba:<br>
<img src="./images/prov.PNG" width="150"><br>

Then take a vector file of a selection of key waterways:<br>
<img src="./images/water.PNG" width="150"><br>

And use PostGIS functions to transform the original map by using the water layer as a "cookie cutter"<br>
<img src="./images/prov2.PNG" width="150"><br>

Exercise 2:<br>
Find out which election candidate lives in or out of the riding in which they are running and for those living outside of their riding, how far away are they located.
Note that the listed home addresses for candidates were published in the Winnipeg Free Press in August 2019 by Elections Manitoba as the per <a href="https://web2.gov.mb.ca/laws/statutes/ccsm/e030e.php">Manitoba Elections Act</a>.

The resuting story can be read here:
https://www.cbc.ca/news/canada/manitoba/manitoba-election-candidate-ridings-1.5267157
