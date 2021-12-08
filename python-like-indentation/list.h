/*
* @Author: sxf
* @Date:   2015-11-29 10:35:00
* @Last Modified by:   sxf
* @Last Modified time: 2015-11-30 15:28:57
*
* 仿Linux的内核链表的实现
* 一个简单双链表
*/

#ifndef LIST_H
#define LIST_H

/**
 * @brief 确定当前成员变量,在结构体中偏移量的宏
 */
#ifndef offsetof
#define offsetof(type, member) ((size_t) &((type*)0)->member)
#endif

/**
 * @brief 根据成员变量,找包含他的结构体指针
 */
#ifndef container_of
#define container_of(ptr, type, member) ({                  \
    const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
    (type *)( (char *)__mptr - offsetof(type,member) );})
#endif


/**
 * @brief 链表初始化宏
 */
#define LIST_INIT(addr) (addr)->next = (addr); (addr)->prev = (addr)



/**
 * @brief 链表节点结构
 */
typedef struct list_node
{
	struct list_node 	*next;
	struct list_node 	*prev;
} list_node;

/**
 * @brief 链表结构体
 */
typedef struct list
{
	list_node* head;
} list;



/**
 * @brief 宏函数, 链表的遍历
 * @details 可以用如下的方式遍历链表
 *  list_for_each(Int_List* , ele, head_node)
 *		// do some work
 *		// ele->some_member
 *	list_for_each_end
 *
 * @param type 节点类型
 * @param ele  遍历的临时变量名称
 * @param list 要遍历的列表
 */
#define list_for_each(type, ele, list) \
	{ type ele; list_node* head = (list_node*)list; list_node* pos= head;  \
		do { ele = (type) pos;

#define list_for_each_end  pos = pos->next;  } while(pos != head); }


/**
 * @brief 链表的节点添加通用函数, 将一个节点添加到两个节点中间
 *
 * @param prev_node 之前一个节点
 * @param next_node 之后一个节点
 * @param new_node 新要添加的节点
 */
static inline void
_list_add(list_node *prev_node, list_node *next_node, list_node *new_node) {
	next_node->prev = new_node;
	new_node->next = next_node;
	new_node->prev = prev_node;
	prev_node->next = new_node;
}


static inline void
_list_remove(list_node *prev_node, list_node *next_node) {
	next_node->prev = prev_node;
	prev_node->next = next_node;
}


/**
 * @brief 在一个list节点后面插入
 *
 * @param node list的节点
 * @param new_node 要插入的新节点
 */
static inline void
list_insert(list_node* head_node, list_node *new_node) {
	_list_add(head_node, head_node->next, new_node);
}


/**
 * @brief 在list的结尾添加新节点
 *
 * @param node list的头节点
 * @param new_node 要插入的新节点
 */
static inline void
list_add(list_node* head_node, list_node *new_node) {
	_list_add(head_node->prev, head_node, new_node);
}


/**
 * @brief 移除尾节点
 * @param head_node list头结点
 * @return 移除的元素指针, 释放内存需调用者手动free这个指针，如果仅有一个节点，则返回这个节点
 */
static inline void*
list_remove_last(list_node* head_node) {
	if (head_node->prev == head_node) return head_node;
	list_node* removed = head_node->prev;
	_list_remove(removed->prev, head_node);
    return removed;
}


/**
 * 将两个链表连在一起，后一个接在前一个末尾
 * @method list_concat
 * @param  head_node   list头结点
 * @param  new_head    第二个列表的头节点
 */
static inline void
list_concat(list_node* head_node, list_node *new_head) {
    list_node* tail = head_node->prev;
    list_node* tail_new = new_head->prev;
    new_head->prev = tail;
	tail->next = new_head;
	head_node->prev = tail_new;
	tail_new->next = head_node;
}


#endif // LIST_H
