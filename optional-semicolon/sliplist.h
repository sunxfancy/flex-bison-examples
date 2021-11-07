/*
* @Author: sxf
* @Date:   2015-11-29 15:15:02
* @Last Modified by:   sxf
* @Last Modified time: 2015-11-30 21:01:47
*/


#ifndef SLIPLIST_H
#define SLIPLIST_H

#include "list.h"

/**
 * 五种链表中的基本类型
 */
typedef enum slip_NodeType
{
	slipL_int_t,
	slipL_float_t,
	slipL_string_t,
	slipL_id_t,
	slipL_list_t,
} slip_NodeType;

typedef union slip_Node slip_Node;


typedef struct slip_NodeBase {
	list_node 		link;
	slip_NodeType 	stype;
} slip_NodeBase;


typedef struct slip_IntNode
{
	slip_NodeBase base;
	int value;
} slip_IntNode;

typedef struct slip_FloatNode
{
	slip_NodeBase base;
	double value;
} slip_FloatNode;


typedef struct slip_StringNode
{
	slip_NodeBase base;
	char* data;
} slip_StringNode;


typedef struct slip_IDNode
{
	slip_NodeBase base;
	char* data;
} slip_IDNode;


typedef struct slip_ListNode
{
	slip_NodeBase base;
	slip_Node* child;
} slip_ListNode;


/**
 * 基本的表节点的聚合
 */
union slip_Node {
	list_node 				link;
	struct slip_NodeBase	b;
	struct slip_IntNode 	i;
	struct slip_FloatNode   f;
	struct slip_StringNode  s;
	struct slip_IDNode  	id;
	struct slip_ListNode    l;
};



extern slip_IntNode* 		slipL_create_IntNode(int num);
extern slip_FloatNode* 		slipL_create_FloatNode(double num);
extern slip_StringNode* 	slipL_create_StringNode(const char* str);
extern slip_IDNode* 		slipL_create_IDNode(const char* str);
extern slip_ListNode* 		slipL_create_ListNode(slip_Node* node);
extern slip_IntNode* 		slipL_create_IntNodeFromStr(const char* str);
extern slip_FloatNode* 		slipL_create_FloatNodeFromStr(const char* str);


extern slip_Node* 			slipL_makeList(int num, ...);
extern slip_NodeType		slipL_getType(slip_Node* node);

/**
 * 给一个列表节点末尾添加兄弟元素
 * @method slipL_addBrother
 * @param  node             必须是一个列表元素
 * @param  add_node         任意一个单个元素
 */
extern void		 			slipL_addBrother(slip_Node* node, slip_Node* add_node);

/**
 * 连接两个链表，将第二个链表连接到第一个链表的末尾
 * @method slipL_concat
 * @param  node         第一个链表首节点
 * @param  add_node     第二个链表首节点
 */
extern void		 			slipL_concat(slip_Node* node, slip_Node* add_node);

extern void					slipL_printList(slip_Node* node, int d);

// 关键的解析函数接口

/**
 * @brief 解析一个文件,将其转换为lisp的表的形式
 *
 * @param path 文件的路径
 * @return lisp表的头节点
 */
extern slip_Node* 			slipL_parseFile(const char* path);

/**
 * @brief 解析一个字符串
 *
 * @param str 待解析的字符串,必须有\0结尾
 * @return lisp表的头节点
 */
extern slip_Node* 			slipL_parseString(const char* str);


static inline slip_Node*
slipL_forward(slip_Node* node) {
	return (slip_Node*) (node->link.next);
}


static inline slip_Node*
slipL_backward(slip_Node* node) {
	return (slip_Node*) (node->link.prev);
}


#endif // SLIPLIST_H
