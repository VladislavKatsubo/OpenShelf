# OpenShelf
Приложение, которое получает и отображает список книг из Open Library и позволяет пользователю просмотреть подробности о каждой книге.

Заранее извиняюсь, что нет осмысленной истории коммитов. 


API

Из всех доступных `endpoint` я выбрал `/subjects/{subject}.json`. Потому что не хочу хранить захардкоженные Open Library ID авторов или книг в приложении (они ведь могут измениться), а других `endpoint` возвращающих массив данных нет (кроме поиска, который работает плохо).

В `/subject` я использовал query параметры, чтобы ограничить количество результатов до 20 с помощью `limit=20` . На будущее, для пагинации, добавил `offset=`

Архитектура - MVVM.
Постарался сделать с учетом SOLID/DI, модульности, переиспользуемости. 

![](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZDIwZjNmZTdiYTcxODU3Y2Y5ZTExZDRkNjk0M2YxNDA4Mzk0ZTE2NSZjdD1n/bdgeyVccVgy1bpmngj/giphy.gif)
