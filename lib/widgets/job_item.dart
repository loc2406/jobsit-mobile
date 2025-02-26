import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsit_mobile/services/base_services.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';

import '../models/job.dart';
import '../utils/value_constants.dart';

class JobItem extends StatelessWidget {
  const JobItem({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context) {

    final startDate = DateTime.tryParse(job.startDate) ?? DateTime.now();
    final endDate = DateTime.tryParse(job.endDate) ?? DateTime.now();
    final differenceInDays = endDate.difference(startDate).inDays;

    return Container(
      margin: EdgeInsets.only(top: ValueConstants.deviceHeightValue(uiValue: 17)),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
             job.companyLogo != null
              ? Image.network('${BaseServices.url}${job.companyLogo}', width: 24, height: 24, errorBuilder: (context, error, stackTrace) => _buildJobDefaultLogo(),)
              : _buildJobDefaultLogo(),
              SizedBox(width: ValueConstants.deviceWidthValue(uiValue: 13),),
              Expanded(child:  Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.jobName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: ColorConstants.main,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  Text(
                    job.companyName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                ],
              ),),
              SizedBox(width: ValueConstants.deviceWidthValue(uiValue: 13),),
              GestureDetector(
                child: const Icon(CupertinoIcons.bookmark_fill, color: ColorConstants.main,),
              )
            ],
          ),
          SizedBox(height: ValueConstants.deviceWidthValue(uiValue: 15),),
          SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: buildJobPositionsList(),
            ),
          ),
          SizedBox(height: ValueConstants.deviceWidthValue(uiValue: 15),),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: ColorConstants.main,),
              Expanded(child: Text(job.location, maxLines: 1, overflow: TextOverflow.ellipsis))
            ],
          ),
          SizedBox(height: ValueConstants.deviceWidthValue(uiValue: 15),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.people, color: ColorConstants.main,),
                  SizedBox(width: ValueConstants.deviceWidthValue(uiValue: 5),),
                  Text(job.amount.toString(),)
                ],
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.clock, color: ColorConstants.main,),
                  SizedBox(width: ValueConstants.deviceWidthValue(uiValue: 5),),
                  Text('${differenceInDays}d left')
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildJobDefaultLogo(){
    return const Icon(
      Icons.image_outlined,
      size: 24,
      color: ColorConstants.main,
    );
  }

  List<Container> buildJobPositionsList() {
    return job.positions
        .map((position) => Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: ColorConstants.grayBackground,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Text(position.name, style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),),
            ))
        .toList();
  }
}
