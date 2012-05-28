#!/bin/bash
DATA_DIR="../../data/movielens/ml-100k/"
LIBS_DIR="../../libs/"
rat1=1
rat2=1
while [ "$rat1" = "$rat2" ]
do
	sort --random-sort $DATA_DIR/converted.data > $DATA_DIR/converted_shufl.data
	first_str=$(cat $DATA_DIR/converted_shufl.data | head -1)
	second_str=$(cat $DATA_DIR/converted_shufl.data | head -2 | tail -1)
	rat1=${first_str:0:1}
        rat2=${second_str:0:1}
done
head -2 $DATA_DIR/converted_shufl.data > $DATA_DIR/test.data
tail -n +3 $DATA_DIR/converted_shufl.data  > $DATA_DIR/train.data

$LIBS_DIR/svm_rank_learn -c 1 $DATA_DIR/train.data $DATA_DIR/model.data
$LIBS_DIR/svm_rank_classify $DATA_DIR/test.data $DATA_DIR/model.data $DATA_DIR/predictions.data

rm $DATA_DIR/length
rm $DATA_DIR/converted.data
rm $DATA_DIR/converted_shufl.data
rm $DATA_DIR/test.data
rm $DATA_DIR/train.data
rm $DATA_DIR/model.data
rm $DATA_DIR/predictions.data
touch $DATA_DIR/converted.data
