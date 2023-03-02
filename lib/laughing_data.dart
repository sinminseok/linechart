/*
Copyright (c) 2022 Razeware LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
distribute, sublicense, create a derivative work, and/or sell copies of the
Software in any work that is designed, intended, or marketed for pedagogical or
instructional purposes related to programming, coding, application development,
or information technology.  Permission for such use, copying, modification,
merger, publication, distribution, sublicensing, creation of derivative works,
or sale is expressly withheld.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

List<WeekData> hourData = [
  //오전
  WeekData(
    days: [
      DayData(
        hour: 1,
        laughs: 1,
      ),
      DayData(
        hour: 1,
        laughs: 1,
      ),
      DayData(
        hour: 2,
        laughs: 1,
      ),
      DayData(
        hour: 3,
        laughs: 1,
      ),
      DayData(
        hour: 4,
        laughs: 1,
      ),
      DayData(
        hour: 5,
        laughs: 1,
      ),
      DayData(
        hour: 6,
        laughs: 1,
      ),
      DayData(
        hour: 6,
        laughs: 1,
      ),
      DayData(
        hour: 7,
        laughs: 1,
      ),

      DayData(
        hour: 8,
        laughs: 1,
      ),
      DayData(
        hour: 9,
        laughs: 1,
      ),
      DayData(
        hour: 10,
        laughs: 1,
      ),
      DayData(
        hour: 11,
        laughs: 1,
      ),

    ],
  ),


  //오후
  WeekData(
    days: [
      //12시
      DayData(
        hour: 0,
        laughs: 9,
      ),
      DayData(
        hour: 1,
        laughs: 6,
      ),
      DayData(
        hour: 2,
        laughs: 11,
      ),
      DayData(
        hour: 3,
        laughs: 8,
      ),
      DayData(
        hour: 4,
        laughs: 14,
      ),
      DayData(
        hour: 5,
        laughs: 10,
      ),
      DayData(
        hour: 6,
        laughs: 4,
      ),
    ],
  ),

];

WeekData zeroStateData = WeekData(
  days: [
    DayData(
      hour: 0,
      laughs: 0,
    ),
    DayData(
      hour: 1,
      laughs: 0,
    ),
    DayData(
      hour: 2,
      laughs: 0,
    ),
    DayData(
      hour: 3,
      laughs: 0,
    ),
    DayData(
      hour: 4,
      laughs: 0,
    ),
    DayData(
      hour: 5,
      laughs: 0,
    ),
    DayData(
      hour: 6,
      laughs: 0,
    ),
  ],
);

class WeekData {
  WeekData({required this.days});
  List<DayData> days;
}

class DayData {
  DayData({required this.hour, required this.laughs});
  int hour;
  int laughs;
}
