LANDSAT Velocities
=======================
by Robert McNabb

*This is a metadata-only repository. Data are only available from the author.*

## Citation

> Robert W. McNabb, Regina Hock, and Matthias Huss (2015). Variations in Alaska Tidewater Glacier Frontal Ablation, 1985–2013. Journal of Geophysical Research: Earth Surface 120, 120-136. doi:[10.1002/2014JF003276](https://doi.org/10.1002/2014JF003276)

## Source data

There are three folders corresponding to the landsat sensor used (TM, ETM, OLI), and inside each folder there's a bunch of `*.tar.gz` files with the actual data.

* `quicklooks.tar.gz` – Different quicklook pngs I produce:
  * `low/*_low.png` – Colormap of velocity magnitudes (saturates at 2 m/d).
  * `quicklooks/*.png` – Colormap of velocity magnitudes (saturates at 10 m/d).
  * `inputs/*_inputs.png` – Figure of the two images used.
  * `vdist/*_vdist.png` – Histogram of the on-glacier velocities.
* `columbia_date1_date2_pathrow_res.tar.gz` – Where `res`(olution) is the pixel distance between chip centers used for matching (i.e., 2 tm pixels = 60 m, 2 oli/etm pixels = 30 m):
  * `*_UU.tif` – Velocity magnitude.
  * `*_Ux.tif` – Velocity x-component.
  * `*_Uy.tif` – Velocity y-component.
  * `*_Cmax.tif` – Highest correlation coefficient.
  * `*_DCorr.tif` – Difference between the first and second-highest correlation value.
  * `*.shp` – ESRI shapefile with fields:
    * `uu` – Velocity magnitude.
    * `ux` – Velocity x-component.
    * `uy` – Velocity y-component.
    * `corr` – Correlation coefficient.
    * `dcorr` – Difference between the first and second-highest correlation value.
    * `centerdate` – Middle of time interval.
    * `image names` – Landsat granules used for the matching.

They haven't been filtered at all, but I did cull any vectors that were more than twice the mean plus twice the standard deviation of the on-glacier velocities. Some of the ETM slc-off scenes might need some work, but fortunately Columbia sits right towards the middle of most of the scenes, so the striping isn't too bad for the terminus region.

### Datums

All GeoTIFFs and Shapefiles are in WGS84 UTM Zone 6N. Date ranges are based on dates only (e.g. 19940101_19940102 = 24 hours). Time can be gleaned from metadata returned by URL queries like:

https://earthexplorer.usgs.gov/form/metadatalookup/?collection_id=3119&entity_id=LT50660171986106XXX03

NOTE: The location of each grid cell center is the position of the tracked feature at the start date of the interval, not its presumed position at the midpoint of the interval.
