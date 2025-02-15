/**
 * File Name: fflib_LogEntry
 *
 * @author architect ir. Wilhelmus G.J. Velzeboer
 *
 * Copyright (c), W.G.J. Velzeboer,
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above author notice,
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 * - Neither the name of the author nor the names of its contributors
 *      may be used to endorse or promote products derived from this software without
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
public with sharing class fflib_LogEntry
{
	public String className { get; set; }
	public String executionContext { get; set; }
	public Decimal lineNumber { get; set; }
	public System.LoggingLevel logLevel { get; set; }
	public String message { get; set; }
	public String methodName { get; set; }
	public Id userId { get; set; }
	public Datetime createdDatetime { get; set; }

	public fflib_LogEntry()
	{
		this(System.LoggingLevel.INFO, null);
	}

	public fflib_LogEntry(System.LoggingLevel loggingLevel, String message)
	{
		this.executionContext = Request.getCurrent().getRequestId() + '/' + Request.getCurrent().getQuiddity();
		this.logLevel = loggingLevel;
		this.message = message;
		this.userId = System.UserInfo.getUserId();
	}

	public fflib_LogEntry(fflib_LogEvent__e logEvent)
	{
		this.className = logEvent.ClassName__c;
		this.executionContext = logEvent.ExecutionContext__c;
		this.lineNumber = logEvent.LineNumber__c;
		this.logLevel = System.LoggingLevel.valueOf(logEvent.LogLevel__c);
		this.message = logEvent.Message__c;
		this.methodName = logEvent.MethodName__c;
		this.userId = logEvent.CreatedById;
		this.createdDatetime = logEvent.CreatedDate;
	}

	public fflib_LogEvent__e toPlatformEvent()
	{
		return new fflib_LogEvent__e(
				ClassName__c = this.className,
				ExecutionContext__c = this.executionContext,
				LineNumber__c = this.lineNumber,
				LogLevel__c = this.logLevel.name(),
				Message__c = this.message,
				MethodName__c = this.methodName
		);
	}
}