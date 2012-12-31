#!/bin/bash

#orignal 601, 1280; 605, 1277
#gdal_translate -of GTiff -a_srs EPSG:3857 -a_ullr -8277212.918945165 5009377.085697312 -8179373.522740141 4931105.56873329 urb_LL.tiff urb_LL.geo.tiff

#altered #1 601, 1280; 605, 1277 opposite corners (LR instead of UL, etc) 
#gdal_translate -of GTiff -a_srs EPSG:3857 -a_ullr -8257645.039704161 5028944.9649383165 -8198941.401981145 4950673.447974294 urb_LL.tiff urb_LL1.geo.tiff

#altered #2 601, 1279; 605, 1276 tried to manually move it down
#gdal_translate -of GTiff -a_srs EPSG:3857 -a_ullr -8277212.918945165 4989809.206456307 -8179373.522740141 4950673.447974294 urb_LL.tiff urb_LL2.geo.tiff

####

gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr -74.35546875 41.244772343082076 -73.4765625 40.58058466412761 urb_LL.tiff urb_LL.geo.tiff

gdalwarp -s_srs EPSG:4326 -t_srs EPSG:3857 urb_LL.geo.tiff urb_LL.geo.3857.tiff

gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr -74.35546875 41.244772343082076 -73.4765625 40.58058466412761 urb_HL.tiff urb_HL.geo.tiff

gdalwarp -s_srs EPSG:4326 -t_srs EPSG:3857 urb_HL.geo.tiff urb_HL.geo.3857.tiff

gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr -74.35546875 41.244772343082076 -73.4765625 40.58058466412761 veg_HL.tiff veg_HL.geo.tiff

gdalwarp -s_srs EPSG:4326 -t_srs EPSG:3857 veg_HL.geo.tiff veg_HL.geo.3857.tiff

gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr -74.35546875 41.244772343082076 -73.4765625 40.58058466412761 veg_LL.tiff veg_LL.geo.tiff

gdalwarp -s_srs EPSG:4326 -t_srs EPSG:3857 veg_LL.geo.tiff veg_LL.geo.3857.tiff
