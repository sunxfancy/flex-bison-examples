/*
* @Author: sxf
* @Date:   2015-11-30 08:34:58
* @Last Modified by:   sxf
* @Last Modified time: 2015-12-03 17:55:44
*/

#include "sliplist.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <assert.h>
#include <string.h>
#include "parser.h"


/**
 * @brief 用在链表数据类型的构造函数中的初始化宏
 */
#define NODE_LIST_CREATE_INIT(this_addr) LIST_INIT(&(this_addr->base.link))

#define STYPE_INIT(type) n->base.stype = type

#define mallocNode(type, ele) type* ele = (type*) malloc(sizeof(type))

slip_IntNode*
slipL_create_IntNode(int num) {
	mallocNode(slip_IntNode, n);
	NODE_LIST_CREATE_INIT(n);
	STYPE_INIT(slipL_int_t);
	n->value = num;
	return n;
}

slip_FloatNode*
slipL_create_FloatNode(double num) {
	mallocNode(slip_FloatNode, n);
	NODE_LIST_CREATE_INIT(n);
	STYPE_INIT(slipL_float_t);
	n->value = num;
	return n;
}

slip_StringNode*
slipL_create_StringNode(const char* str) {
	mallocNode(slip_StringNode, n);
	NODE_LIST_CREATE_INIT(n);
	STYPE_INIT(slipL_string_t);
	int len = strlen(str);
	char* buf = (char*) malloc (len+1);
	n->data = strcpy(buf, str);
	return n;
}

slip_IDNode*
slipL_create_IDNode(const char* str) {
	mallocNode(slip_IDNode, n);
	NODE_LIST_CREATE_INIT(n);
	STYPE_INIT(slipL_id_t);
	int len = strlen(str);
	char* buf = (char*) malloc (len+1);
	n->data = strcpy(buf, str);
	return n;
}

slip_ListNode*
slipL_create_ListNode(slip_Node* node) {
	mallocNode(slip_ListNode, n);
	NODE_LIST_CREATE_INIT(n);
	STYPE_INIT(slipL_list_t);
	n->child = node;
	return n;
}

slip_IntNode*
slipL_create_IntNodeFromStr(const char* str) {
	int value = strtol(str, NULL, 0);
	return slipL_create_IntNode(value);
}

slip_FloatNode*
slipL_create_FloatNodeFromStr(const char* str) {
	double value = atof(str);
	printf("value=%.2f\n", value);
	return slipL_create_FloatNode(value);
}

slip_Node*
slipL_makeList(int num, ...) {
	va_list argp; slip_Node* para = NULL;
	slip_Node* ans = NULL;
	va_start( argp, num );
    for (int i = 0; i < num; ++i) {
        para = va_arg( argp, slip_Node* );
        if ( ans == NULL )
        	ans = para;
        else slipL_addBrother(ans, para);
    }
    va_end( argp );
    return ans;
}

slip_NodeType
slipL_getType(slip_Node* node) {
	return node->b.stype;
}

void
slipL_addBrother(slip_Node* node, slip_Node* add_node) {
	list_add(&(node->b.link), &(add_node->b.link));
}

void
slipL_concat(slip_Node* node, slip_Node* add_node) {
	list_concat(&(node->b.link), &(add_node->b.link));
}



static void
printList_Node(slip_Node* node) {
	if (node == NULL) return;
	switch(node->b.stype) {
		case slipL_int_t: printf("int %d", node->i.value); break;
		case slipL_float_t: printf("float %f", node->f.value); break;
		case slipL_string_t: printf("string %s", node->s.data); break;
		case slipL_id_t: printf("id %s", node->id.data); break;
		case slipL_list_t: printf("list"); break;
	}
	printf("\n");
}

void
slipL_printList(slip_Node* node, int d) {
	if (node == NULL) {
		printf("链表空节点\n");
		return;
	}
	// 这里一定要先循环, 在判断类型, 因为最外层可能不只有一个表
	list_for_each(slip_Node*, p, node)
		for (int i = 0; i < d; ++i) {
			printf("    ");
		}
		printList_Node(p);
		if (p && p->b.stype == slipL_list_t) {
			slip_Node* child = p->l.child;
			slipL_printList(child, d+1);
		}
	list_for_each_end
}



extern slip_Node* programBlock;
extern void slip_scan_string(const char *str);
extern void slip_reset_file(FILE* f);

slip_Node* slipL_parseFile(const char* path) {
	programBlock = NULL;
	FILE* file_in;
	if ((file_in = fopen(path, "r")) == NULL) {
		printf("找不到程序源文件: %s\n", path);
		return 0;
	}
	slip_reset_file(file_in);
	yyparse();
	fclose(file_in);
	// 打印语法树
	printf("源文件 - %s\n", path);
	slipL_printList(programBlock, 0);
	printf("\n\n");
	return programBlock;
}

slip_Node* slipL_parseString(const char* str) {
	programBlock = NULL;
	char* buffer;
	int buffer_size = strlen(str);
	// 分配buffer
	buffer = (char*) malloc(buffer_size);
	assert(buffer != NULL);
	strcpy(buffer, str);
	// 正式解析
	slip_scan_string(buffer); // 这句话只是在设置缓冲区
	yyparse(); // 执行解析
	// 释放资源
	free(buffer);
	// 打印语法树
	slipL_printList(programBlock, 0);
	return programBlock;
}
