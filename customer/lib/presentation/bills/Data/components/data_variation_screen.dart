import 'package:acoride/logic/cubits/variation_cubit.dart';
import 'package:acoride/logic/states/variation_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/helper_color.dart';
import '../../../../core/helper/helper_style.dart';


class VariationScreen extends StatefulWidget {
  final String? type;
  const VariationScreen({Key? key,required this.type}) : super(key: key);

  @override
  VariationScreenState createState() {
    return VariationScreenState();
  }

}

class VariationScreenState extends State<VariationScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VariationCubit>(
      create: (context) => VariationCubit(VariationState(message: widget.type!)),
      child: BlocBuilder<VariationCubit, VariationState>(
        builder: (dataCubit, dataState) {
          return SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height/1.2,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
                        padding: const EdgeInsets.all(15.0),
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(13)),
                        ),
                        child:Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Select Plan', style: HelperStyle.textStyle(context, Colors.black, 18.sp, FontWeight.w500)),
                                  GestureDetector(
                                    child: const Icon(Icons.close, color: Colors.black,),
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                margin: const EdgeInsets.all(15),
                                child: Row(
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        onChanged: (searchText) {
                                          dataCubit.read<VariationCubit>().filterName(searchText);
                                        },

                                        decoration:  InputDecoration(
                                          filled: true,
                                          fillColor: HelperColor.fillColor,
                                          hintText: "Search Type",
                                          isDense: true,
                                          border: const OutlineInputBorder(),
                                          contentPadding: const EdgeInsets.all(8.0),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: const BorderSide(color: Colors.transparent, width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent, width: 1.0),
                                          ),
                                          // contentPadding: const EdgeInsets.all(5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              dataState.isLoading?
                              const LinearProgressIndicator(
                                minHeight: 1,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                              ):
                              Expanded(
                                child:ListView.builder(
                                  shrinkWrap: true,
                                  primary: true,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context, dataState.variationModel[index]);
                                      },
                                      child:ListTile(
                                        title: Text(
                                          dataState.variationModel[index].name ?? '',
                                          style: HelperStyle.textStyle(context,Colors.black,14,FontWeight.bold),
                                        ),
                                        trailing: const Icon(Icons.chevron_right),
                                      ),
                                    );
                                  },
                                  itemCount: dataState.variationModel.length,
                                ),
                              ),
                            ]
                        ),
                      ),
                    );
                  },
                )
            ),
          );
        },
      ),
    );
  }
}