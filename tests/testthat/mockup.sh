#!/bin/bash

# Set up the data structure needed for the tests
# (see setup.csv)

$OMERO_HOME/bin/omero login root@localhost -w $OMERO_ROOT_PASS
$OMERO_HOME/bin/omero obj new Dataset name=TestDataset
$OMERO_HOME/bin/omero obj new Project name=TestProject
$OMERO_HOME/bin/omero obj new ProjectDatasetLink parent=Project:1 child=Dataset:1
touch "8bit-unsigned&pixelType=uint8&sizeZ=3&sizeC=5&sizeT=7&sizeX=512&sizeY=512.fake"
$OMERO_HOME/bin/omero import "8bit-unsigned&pixelType=uint8&sizeZ=3&sizeC=5&sizeT=7&sizeX=512&sizeY=512.fake" -T Dataset:id:1
rm "8bit-unsigned&pixelType=uint8&sizeZ=3&sizeC=5&sizeT=7&sizeX=512&sizeY=512.fake"

$OMERO_HOME/bin/omero obj new CommentAnnotation textValue=BlaBla
$OMERO_HOME/bin/omero obj new ImageAnnotationLink parent=Image:1 child=CommentAnnotation:1
touch test.csv
$OMERO_HOME/bin/omero upload test.csv
rm test.csv
$OMERO_HOME/bin/omero obj new FileAnnotation file=OriginalFile:49
$OMERO_HOME/bin/omero obj new ImageAnnotationLink parent=Image:1 child=FileAnnotation:2

$OMERO_HOME/bin/omero obj new Screen name=TestScreen
touch "SPW&plates=1&plateRows=8&plateCols=8&fields=4&plateAcqs=1.fake"
$OMERO_HOME/bin/omero import "SPW&plates=1&plateRows=8&plateCols=8&fields=4&plateAcqs=1.fake" -T Screen:id:1
rm "SPW&plates=1&plateRows=8&plateCols=8&fields=4&plateAcqs=1.fake"

$OMERO_HOME/bin/omero obj new MapAnnotation
$OMERO_HOME/bin/omero obj map-set MapAnnotation:3 mapValue testkey testvalue
$OMERO_HOME/bin/omero obj new ScreenAnnotationLink parent=Screen:1 child=MapAnnotation:3

$OMERO_HOME/bin/omero logout

