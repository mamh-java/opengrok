/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License (the "License").
 * You may not use this file except in compliance with the License.
 *
 * See LICENSE.txt included in this distribution for the specific
 * language governing permissions and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at LICENSE.txt.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */

/*
 * Copyright (c) 2019, Chris Fraire <cfraire@me.com>.
 */

package org.opengrok.indexer.analysis.verilog;

import java.io.IOException;
import java.util.Set;
import org.opengrok.indexer.web.HtmlConsts;
%%
%public
%class VerilogXref
%extends VerilogLexer
%char
%unicode
%int
%include ../CommonLexer.lexh
%include ../CommonXref.lexh
%{
    @Override
    public void offer(String value) throws IOException {
        onNonSymbolMatched(value, yychar);
    }

    @Override
    public boolean offerSymbol(String value, int captureOffset,
            boolean ignoreKwd) throws IOException {
        Set<String> keywords = ignoreKwd ? null : Consts.kwd;
        return onFilteredSymbolMatched(value, yychar, keywords, true);
    }

    @Override
    public void skipSymbol() {
        // noop
    }

    @Override
    public void offerKeyword(String value) throws IOException {
        onKeywordMatched(value, yychar);
    }

    @Override
    public void startNewLine() throws IOException {
        onEndOfLineMatched("\n", yychar);
    }

    @Override
    public void disjointSpan(String className) throws IOException {
        onDisjointSpanChanged(className, yychar);
    }

    protected boolean takeAllContent() {
        return true;
    }

    protected boolean returnOnSymbol() {
        return false;
    }

    /**
     * Gets the constant value created by JFlex to represent COMMENT.
     */
    @Override
    int COMMENT() { return COMMENT; }

    /**
     * Gets the constant value created by JFlex to represent SCOMMENT.
     */
    @Override
    int SCOMMENT() { return SCOMMENT; }
%}

%include ../Common.lexh
%include ../CommonURI.lexh
%include VerilogProductions.lexh
