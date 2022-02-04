# Code Documentation
## Alaattin Bulut Oztemur





### Architecture

- I preferred using MVVM, it is simple to use and it is good at seperating concerns (UI Logic and Business Logic). It makes writing unit test easier. Of course, there are some different architectures, but I think MVVM is suitable for a project of this scale.

### Filter Algorithm

- I preferred using Binary Search algorithm.
- When I find the first the word having search string as prefix, I traverse its left and right adjacents that having the same prefix. So time complexity is O(logn+k+l). logn for binary search, k for left adjacents, l for right adjacents. Here, k and l have not big efficiency, so they can be ignored. It has pretty better time complexity than linear search O(n). 
- O(n) > O(log+k+l)
- I created an util class FilterUtil for filter operation. I create a protocol Filterable, and my filter functions take array of instances that conforms to Filterable protocol as a parameter. Inside Filterable, there is just one variable called filterString which is used by filter functions to check having input prefix. So, I assign name value of the city instance to filterString.

### Unit Test

- I writed many tests for filtering algorithm to cover all cases. I used mocking technique via cities json file and an empty json file. 
- I also wrote an improved linear search algorithm to compare mine. Improved means that after finding filtered array, it returns immediately. It doesn't have to traverse all array. So, when search string's initial character is in earlier (a,b,c etc.), it is best case for it. In contrast, if it is in later (x,y,z etc.), it is worst case for it.
- I performed three performance tests to compare two algorithms. I tested search string "Ams", "Kala", "Zaba" respectively. Results are below. 
- It can be seen that, if the initial character of the search string is earlier character, linear search gives a little bit better result. But if the initial character is middle or later character, binary search algorithm gives much better solution. 
- Overall, if we compare average cases, binary search filtering is pretty better than linear search filtering. O(logn+k+l) < O(n-m+k+l). Here, k+l is the length of filtered array. m is the first index of the element having the search string as prefix. To sum up, binary search is much better than linear search in average case.

| Search String/Algorithm | My Filtering Algorithm  | Improved Linear Search Filtering  |
| ------- | --- | --- |
| Ams  | 5.379 sec | 5.222 sec | 
| Kala | 5.293 sec | 5.644 sec | 
| Zaba | 5.250 sec | 5.998 sec |

## UI Implementation
- I created a responsive tableview.
- I created a no data view that presented when there is no result in search operation.
- I built a launch screen. Because of decoding and sorting operations, the user waits here for a short time.

## Version Control
- I use GIT as version control system. I made commits for each small feature seperately. I worked on main branch and didn't create another branch. I didn't find it necessary since I worked alone and the project is not big. Sure, in an ideal world, it should be worked with different branches and pull requests.
