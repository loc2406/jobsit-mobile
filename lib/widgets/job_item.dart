import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';

import '../models/job.dart';

class JobItem extends StatelessWidget {
  JobItem({super.key, required this.job});

  final Job job;
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final differenceInDays = now.difference(DateTime.tryParse(job.endDate) ?? DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.image_outlined,
                size: 24,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    job.companyName,
                    style: const TextStyle(
                        color: ColorConstants.main,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  // Text(
                  //   job.companyDescription,
                  //   style: const TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 13),
                  // ),
                ],
              ),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.bookmark,
                    color: ColorConstants.main,
                  ))
            ],
          ),
          SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: buildJobPositionsList(),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: ColorConstants.main,),
              Expanded(child: Text(job.companyLocation, maxLines: 1, overflow: TextOverflow.ellipsis))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.people, color: ColorConstants.main,),
                  Text(job.amount.toString(),)
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.alarm, color: ColorConstants.main,),
                  Text('$differenceInDays days left')
                ],
              )
            ],
          )
        ],
      ),
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
