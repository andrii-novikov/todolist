app = angular.module('app');

app.factory('Task', ($resource)->
  return $resource('/tasks/:id.json', { id:'@id' }, {
    save: { method: 'PUT' }
    create: {method:'POST'}
    statuses: {url:'/tasks/statuses.json', isArray:true}
    createComment: {method:'POST', url:'/tasks/:task_id/comments.json'}
    deleteComment: {method:'DELETE', url:'/tasks/:task_id/comments/:id.json'}
  });
)